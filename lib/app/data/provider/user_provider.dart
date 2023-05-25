import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:mp23_astr/app/data/model/user.dart';

class UserProvider extends GetConnect {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<UserModel> getUser(String uid) {
    return firestore.collection('Users').doc(uid).get().then((doc) {
      UserModel userModel = UserModel.fromDocumentSnapshot(doc);
      return userModel;
    });
  }

  Future<void> assignShoppingList(String uid, String shoppingListId) async {
    //This part of the code check if the user already have the shoppingList in his/her basket,
    //as we don't want the same shopping to appear multiple times in the shoppingListIds of the User.
    DocumentReference<Map<String, dynamic>> docRef =
        firestore.collection('Users').doc(uid);

    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await docRef.get();

    if (documentSnapshot.exists &&
        documentSnapshot.data() != null &&
        documentSnapshot.data()!['shoppingListIds'] != null &&
        documentSnapshot.data()!['shoppingListIds'].contains(shoppingListId)) {
      return;
    }
    //if the user doesn't have the shoppingList we add it.
    return firestore.collection('Users').doc(uid).update({
      'shoppingListIds': FieldValue.arrayUnion([shoppingListId])
    });
  }

  Future<void> deAssignShoppingList(String uid, String shoppingListId) {
    return firestore.collection('Users').doc(uid).update({
      'shoppingListIds': FieldValue.arrayRemove([shoppingListId])
    });
  }

  Future<List<UserModel>> getAll() async {
    try {
      List<UserModel> userList = [];

      final QuerySnapshot<Map<String, dynamic>> collection =
          await firestore.collection("Users").get();
      for (int i = 0; i < collection.docs.length; i++) {
        userList.add(UserModel.fromDocumentSnapshot(collection.docs[i]));
      }
      return userList;
    } catch (e) {
      rethrow;
    }
  }

  addFcmToken(uid, String token) {
    //Add the fcm token to the list of fcmTokens if the fcmTokens field exists, otherwise create it with one entry
    firestore.collection('Users').doc(uid).update({
      'fcmTokens': FieldValue.arrayUnion([token])
    });
  }
}
