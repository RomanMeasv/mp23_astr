const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

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
    const listId = context.params.listId;

    //Fetch the user that have the list id in their shoppingListIds list
    const users = await admin.firestore().collection('Users').where('shoppingListIds', 'array-contains', listId).get();

    // Get the tokens of the users, the tokens are stored as an array in the user document
    let allFcmTokens = []; //TODO: The user's own token might be excluded, but it's easier to test
    users.forEach(user => {
        allFcmTokens = allFcmTokens.concat(user.data().fcmTokens);
    });

    // Construct the notification message that it includes the name of the shopping list, who added and what
    const payload = {
        notification: {
            title: 'New item added to a shopping list!',
            body: `${snap.data().addedBy} added ${snap.data().name} to the shopping list ${snap.data().listName}`,
        }
    };

    // Send the notification to all tokens
    const response = await admin.messaging().sendToDevice(allFcmTokens, payload);

    // Handle if tokens have been invalidated or expired
    response.failureCount > 0 && response.responses.forEach((resp, idx) => {
        if (!resp.success) {
            // remove the failed token
            let failed_token = allFcmTokens[idx];
            //TODO: remove the `failed_token` from the users `fcmTokens` array
            console.log('Failure sending notification to', failed_token, resp.error);
        }
    });

    return null;
});


