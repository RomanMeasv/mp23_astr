import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_connect/connect.dart';
import 'package:mp23_astr/app/data/model/user.dart';

class UserProvider extends GetConnect {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserModel> getUser(String uid) {
    return firestore.collection('Users').doc(uid).get().then((value) {
      UserModel userModel = UserModel.fromJson(value.data()!);
      userModel.uid = value.id;
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

      final QuerySnapshot<Map<String, dynamic>> snapshot =
      await firestore.collection("Users").get();
      snapshot.docs.map((e) => userList.add(UserModel.fromJson(e.data())));
      for (int i = 0; i < snapshot.docs.length; i++) {
        userList.add(UserModel.fromJson(snapshot.docs[i].data()));
      }
      print("IN PROVIDER: ${userList.length}");
      return userList;
    } catch (e) {
      print("Provider error (getAllUsers): $e");
      rethrow;
    }
  }
}
