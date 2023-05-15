import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> assignShoppingList(String uid, String shoppingListId) {
    print("USERID: ${uid} Shopping ListID: ${shoppingListId}");
    return firestore.collection('Users').doc(uid).update({
      'shoppingListIds': FieldValue.arrayUnion([shoppingListId])
    });
  }

  Future<void> deAssignShoppingList(String uid, String shoppingListId) {
    List<dynamic> listToRemove = <dynamic>[];
    listToRemove.add(shoppingListId);
    
    return firestore
        .collection('Users')
        .doc(uid)
        .update({'shoppingListIds': FieldValue.arrayRemove(listToRemove)});
  }


  Future<List<UserModel>> getAll() async {
    try {
      List<UserModel> userList = [];

      final QuerySnapshot<Map<String, dynamic>> collection =
      await firestore.collection("Users").get();

      collection.docs.map((doc) => userList.add(UserModel.fromDocumentSnapshot(doc)));

      print("IN PROVIDER: ${userList.length}");
      return userList;
    } catch (e) {
      print("Provider error (getAllUsers): $e");
      rethrow;
    }
  }
}
