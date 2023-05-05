import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_connect/connect.dart';
import 'package:mp23_astr/app/data/model/item.dart';

class ItemProvider extends GetConnect {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ItemModel>> getAll(shoppingListId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection("ShoppingList")
          .doc(shoppingListId)
          .collection("Item")
          .get();

      List<ItemModel> list = snapshot.docs.map((doc) {
        return ItemModel.fromJson(doc.data());
      }).toList();

      print("Data retrieved successfully");
      return list;
    } catch (e) {
      print("Provider error (getAll): $e");
      rethrow;
    }
  }

  Future<ItemModel> getById(shoppingListId, itemId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection("ShoppingList")
          .doc(shoppingListId)
          .collection("Item")
          .doc(itemId)
          .get();

      ItemModel item = ItemModel.fromJson(snapshot.data()!);
      return item;
    } catch (e) {
      print("Provider error (getById): $e");
      rethrow;
    }
  }

  edit(obj) {}

  Future<ItemModel> addItem(String shoppingListId, ItemModel item) async {
    try {
      // Get a reference to the collection you want to add data to
      final collectionRef = FirebaseFirestore.instance
          .collection("ShoppingList")
          .doc(shoppingListId)
          .collection("Item");

      // Create a new document with auto-generated ID
      final newDocRef = await collectionRef.add(item.toJson());
      final newItemId = newDocRef.id;

      ItemModel newItem = await getById(shoppingListId, newItemId);

      print("Data added successfully");
      return newItem;
    } catch (e) {
      print("Provider error (addItem): $e");
      rethrow;
    }
  }

  Future<String?> uploadImage(XFile? file) async {
    if (file == null) return null;

    // Create a reference to the file location
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final storageRef = FirebaseStorage.instance.ref().child("images/$fileName");

    // Upload the file to the storage location
    final uploadTask = storageRef.putFile(File(file.path));

    // Wait for the upload to complete and return the download URL
    final snapshot = await uploadTask;
    final downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
}
