const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.createUserOnSignUp = functions.auth
    .user()
    .onCreate((user) => {
        admin.firestore().collection("users").doc(user.uid)
        .set({
            uid: user.uid,
            email: user.email,
            shoppingListIds: [],
        });
});
