const functions = require("firebase-functions");
const admin = require("firebase-admin");
const serviceAccount = require("./mp23-astr-firebase-adminsdk-3gl9w-984d3164ee.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://mp23-astr-default-rtdb.europe-west1.firebasedatabase.app"
});

exports.createUserOnSignUp = functions.auth.user().onCreate(async (user) => {
  const userData = {
    email: user.email,
    shoppingListIds: []
  };

  const userDocRef = admin.firestore().collection("Users").doc(user.uid);
  await userDocRef.set(userData);
});

exports.sendNotificationWhenNewItemIsAddedToAShoppingListOfTheUser = functions.firestore
  .document('ShoppingLists/{listId}/Items/{itemId}')
  .onCreate(async (snap, context) => {
    const listId = context.params.listId;
    const listSnapshot = await admin.firestore().collection('ShoppingLists').doc(listId).get();
    const listName = listSnapshot.data().name;

    const itemName = snap.data().text;

    const titles = [
      `📢 Item added!`,
      `🎉 A new item joins the list!`,
      `🛍️ Another one buys the stuff!`
    ];

    const payload = {
      notification: {
        title: titles[Math.floor(Math.random() * titles.length)],
        body: `${itemName} was added to ${listName}`
      }
    };

    const usersSnapshot = await admin.firestore().collection('Users').where('shoppingListIds', 'array-contains', listId).get();

    const allFcmTokens = [];
    usersSnapshot.forEach(user => {
      allFcmTokens.push(...user.data().fcmTokens);
    });

    const response = await admin.messaging().sendToDevice(allFcmTokens, payload);

    //If a notification fails to send, remove the token from the user's fcmTokens array
    if (response.failureCount > 0) {
        for (let idx = 0; idx < response.responses.length; idx++) {
            const resp = response.responses[idx];
            if (!resp.success) {
                // remove the failed token, keeping in mind that one user might have multiple tokens
                const failed_token = allFcmTokens[idx];
                console.log('Failure sending notification to', failed_token, resp.error);
                // Fetch users who have this FCM token - it is generally assumed that there is only one user having this token, but it is possible that there are more, if e.g. 2 users share the same device
                const failed_token_users = await admin.firestore().collection('Users').where('fcmTokens', 'array-contains', failed_token).get();

                // Remove the failed token from each user
                failed_token_users.forEach(doc => {
                    doc.ref.update({
                        fcmTokens: admin.firestore.FieldValue.arrayRemove(failed_token),
                    });
                });
            }
        }
    }
});