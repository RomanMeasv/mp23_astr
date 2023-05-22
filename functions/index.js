const functions = require("firebase-functions");
const admin = require("firebase-admin");
var serviceAccount = require("./mp23-astr-firebase-adminsdk-3gl9w-984d3164ee.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://mp23-astr-default-rtdb.europe-west1.firebasedatabase.app"
});

exports.createUserOnSignUp = functions.auth
    .user()
    .onCreate((user) => {
        admin.firestore().collection("Users").doc(user.uid)
        .set({
            email: user.email,
            shoppingListIds: [],
        });
});

exports.sendNotificationWhenNewItemIsAddedToAShoppingListOfTheUser = functions.firestore
.document('ShoppingLists/{listId}/Items/{itemId}')
.onCreate(async (snap, context) => {
    // Get the name of the shopping list
    const listId = context.params.listId;
    const listSnapshot = await admin.firestore().collection('ShoppingLists').doc(listId).get();
    const listName = listSnapshot.data().name;

    const itemName = snap.data().text;

    let titles = [
        `📢 Item added!`,
        `🎉 A new item joins the list!`,
        `🛍️ Another one buies the stuff!`,
        ]

    // Construct the notification message that it includes the name of the shopping list, and what item was added (text)
    const payload = {
        notification: {
            title: titles[Math.floor(Math.random()*titles.length)],
            body: `${itemName} was added to ${listName}`,
        }
    };

    //Fetch the user that have the list id in their shoppingListIds list
    const users = await admin.firestore().collection('Users').where('shoppingListIds', 'array-contains', listId).get();

    // Get the tokens of the users, the tokens are stored as an array in the user document
    let allFcmTokens = []; //TODO: The user's own token might be excluded, but it's easier to test
    users.forEach(user => {
        allFcmTokens = allFcmTokens.concat(user.data().fcmTokens);
    });

    // Send the notification to all tokens
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

    return null;
});

