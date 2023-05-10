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
