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

      final collectionRef = _firestore.collection("ShoppingLists");


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
    final collectionRef = _firestore
        .collection("ShoppingLists")
        .doc(shoppingListID)
        .set(shoppingList.toJson());
    return shoppingList;
  }

  deleteShoppingList(String userID, ShoppingListMenuModel shoppingList) async {
    if (userID != shoppingList.owner) {
      List<dynamic> listToRemove = <dynamic>[];
      listToRemove.add(shoppingList.uid);
      await _firestore
          .collection('Users')
          .doc(userID)
          .update({'shoppingListIds': FieldValue.arrayRemove(listToRemove)});
      return;
    }
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection("Users")
        .where("shoppingListIds", arrayContains: shoppingList.uid)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      await FirebaseFirestore.instance.collection('Users').doc(doc.id).update({
        'shoppingListIds': FieldValue.arrayRemove([shoppingList.uid])
      });
    }
    await FirebaseFirestore.instance
        .collection("ShoppingLists")
        .doc(shoppingList.uid)
        .delete();
  }

  Future<List<ShoppingListMenuModel>> getAll(
      List<String> shoppingListIDs) async {
    try {
      List<ShoppingListMenuModel> shoppingLists = [];
      for (var shoppingListID in shoppingListIDs) {
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
            .collection("ShoppingLists")
            .doc(shoppingListID)
            .get();
        if (snapshot.data() == null || snapshot.data()!['name'] == null)
          continue;
        ShoppingListMenuModel shoppingList =
            ShoppingListMenuModel.fromDocumentSnapshot(snapshot);
        CollectionReference itemsCollection = _firestore
            .collection("ShoppingLists")
            .doc(shoppingListID)
            .collection('Items');
        QuerySnapshot snapshotItem = await itemsCollection.get();
        int itemCount = snapshotItem.size;
        shoppingList.itemCount = itemCount;
        shoppingLists.add(shoppingList);
      }
      return shoppingLists;
    } catch (e) {
      print("Provider error (getAll): $e");
      rethrow;
    }
  }
}
