import 'package:get/get_connect/connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mp23_astr/app/data/model/shopping_list_menu.dart';

const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class ShoppingListMenuProvider extends GetConnect {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<ShoppingListMenuModel> getById(shoppingListId) async {
  //   try {
  //     final DocumentSnapshot<Map<String, dynamic>> snapshot =
  //         await _firestore.collection("ShoppingList").doc(shoppingListId).get();

  //     ShoppingListMenuModel shoppingList =
  //         ShoppingListMenuModel.fromJson(snapshot.data()!);
  //     return shoppingList;
  //   } catch (e) {
  //     print("Provider error (getById): $e");
  //     rethrow;
  //   }
  // }

  Future<Map<String, dynamic>> addShoppingList(
      Map<String, dynamic> shoppingList) async {
    try {
      final collectionRef =
          FirebaseFirestore.instance.collection("ShoppingList");

      final newDocRef = await collectionRef.add(shoppingList);

      shoppingList["id"] = newDocRef.id;
      return shoppingList;
      // final collectionRef =
      //     FirebaseFirestore.instance.collection("ShoppingList");

      // final newDocRef = await collectionRef.add(shoppingList.toJson());
      // final newShoppingListId = newDocRef.id;
      // print("ID ");
      // print(newDocRef.id);

      // ShoppingListMenuModel newShoppingList = await getById(newShoppingListId);
      // newShoppingList.id = newDocRef.id;
      // return newShoppingList;
    } catch (e) {
      print("Provider error (addItem): $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateShoppingList(
      String shoppingListID, Map<String, dynamic> shoppingList) async {
    final collectionRef = FirebaseFirestore.instance
        .collection("ShoppingList")
        .doc(shoppingListID)
        .set(shoppingList);
    //ShoppingListMenuModel updatedShoppingList = await getById(shoppingListID);
    return shoppingList;
  }

  Future<List<ShoppingListMenuModel>> getAll(List<String> shoppingListIDs) async {
    try {
      List<ShoppingListMenuModel> shoppingLists = [];
      for (var shoppingListID in shoppingListIDs) {
        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await _firestore.collection("ShoppingList").doc(shoppingListID).get();

        ShoppingListMenuModel shoppingList =
            ShoppingListMenuModel.fromDocumentSnapshot(snapshot);
        shoppingLists.add(shoppingList);
        print("Provider:" + shoppingListID);
      }
      return shoppingLists;
      // List<ShoppingListMenuModel> list = snapshot.docs.map((doc) {
      //   return ShoppingListMenuModel.fromJson(doc.data());
      // }).toList();
      // print("IN PROVIDER");
      // print(list.length);

      // print("Data retrieved successfully");
      // return list;
    } catch (e) {
      print("Provider error (getAll): $e");
      rethrow;
    }
  }
}
