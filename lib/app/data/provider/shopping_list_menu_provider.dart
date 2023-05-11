import 'package:get/get_connect/connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mp23_astr/app/data/model/shopping_list_menu.dart';

import '../model/user.dart';

const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class ShoppingListMenuProvider extends GetConnect {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ShoppingListMenuModel> addShoppingList(
      ShoppingListMenuModel shoppingList) async {
    try {
      final collectionRef =
          FirebaseFirestore.instance.collection("ShoppingList");

      final newDocRef = await collectionRef.add(shoppingList.toJson());

      shoppingList.uid = newDocRef.id;
      return shoppingList;
    } catch (e) {
      print("Provider error (addItem): $e");
      rethrow;
    }
  }

  Future<ShoppingListMenuModel> updateShoppingList(
      String shoppingListID, ShoppingListMenuModel shoppingList) async {
    final collectionRef = FirebaseFirestore.instance
        .collection("ShoppingList")
        .doc(shoppingListID)
        .set(shoppingList.toJson());
    return shoppingList;
  }

  deleteShoppingList(String shoppingListID) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("users")
        .where("shoppingListIds", arrayContains: shoppingListID)
        .get();
    List<dynamic> listToRemove = <dynamic>[];
    listToRemove.add(shoppingListID);
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      final Map<String, dynamic> data = doc.data();
      print("User Id ${data['uid']}");
      // Access specific fields in the data map

      await FirebaseFirestore.instance
          .collection('users')
          .doc(data['uid'])
          .update({'shoppingListIds': FieldValue.arrayRemove(listToRemove)});
      // Do something with the extracted data
    }
    final collectionRef = await FirebaseFirestore.instance
        .collection("ShoppingList")
        .doc(shoppingListID)
        .delete();
  }

  Future<List<ShoppingListMenuModel>> getAll(
      List<String> shoppingListIDs) async {
    try {
      print("Shopping in provider: ${shoppingListIDs}");
      List<ShoppingListMenuModel> shoppingLists = [];
      for (var shoppingListID in shoppingListIDs) {
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
            .collection("ShoppingList")
            .doc(shoppingListID)
            .get();
        if (snapshot.data()!['name'] == null) continue;
        ShoppingListMenuModel shoppingList =
            ShoppingListMenuModel.fromDocumentSnapshot(snapshot);
        shoppingLists.add(shoppingList);
        print("Provider:" + shoppingListID);
      }
      return shoppingLists;
    } catch (e) {
      print("Provider error (getAll): $e");
      rethrow;
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      List<UserModel> userList = [];

      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection("users").get();
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
