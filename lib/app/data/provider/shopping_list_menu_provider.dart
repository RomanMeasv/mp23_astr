import 'package:get/get_connect/connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mp23_astr/app/data/model/shopping_list_menu.dart';

const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class ShoppingListMenuProvider extends GetConnect {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ShoppingListMenuModel> getById(shoppingListId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection("ShoppingList").doc(shoppingListId).get();

      ShoppingListMenuModel shoppingList =
          ShoppingListMenuModel.fromJson(snapshot.data()!);
      return shoppingList;
    } catch (e) {
      print("Provider error (getById): $e");
      rethrow;
    }
  }

  Future<ShoppingListMenuModel> addShoppingList(
      ShoppingListMenuModel shoppingList) async {
    try {
      final collectionRef =
          FirebaseFirestore.instance.collection("ShoppingList");

      final newDocRef = await collectionRef.add(shoppingList.toJson());
      final newShoppingListId = newDocRef.id;
      print("ID ");
      print(newDocRef.id);

      ShoppingListMenuModel newShoppingList = await getById(newShoppingListId);
      print("new Shopping List");
      print(newShoppingList);
      print("Data added successfully");
      newShoppingList.id = newDocRef.id;
      return newShoppingList;
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
        .set({'name': shoppingList.name, 'date': shoppingList.date});
    ShoppingListMenuModel updatedShoppingList = await getById(shoppingListID);
    return updatedShoppingList;
  }

  Future<List<ShoppingListMenuModel>> getAll() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection("ShoppingList").get();
      print("Query");
      print(snapshot.docs.map((e) => e.data()));
      List<ShoppingListMenuModel> list = snapshot.docs.map((doc) {
        return ShoppingListMenuModel.fromJson(doc.data());
      }).toList();
      print("Data retrieved successfully");
    } catch (e) {
      print("Provider error (getAll): $e");
      rethrow;
    }
    return [];
  }
}
