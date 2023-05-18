import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_connect/connect.dart';
import 'package:mp23_astr/app/data/model/item.dart';

class ItemProvider extends GetConnect {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final shoppingListCollection = "ShoppingList";
  final itemCollection = "Item";
  final imageCollection = "Image/";

  Future<List<ItemModel>> getAllItems(shoppingListId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection(shoppingListCollection)
          .doc(shoppingListId)
          .collection(itemCollection)
          .get();

      final List<ItemModel> items = snapshot.docs
          .map((item) => ItemModel.fromJson(item.id, item.data()))
          .toList();

      print("Items retrieved successfully (getAll): $items");

      return items;
    } catch (e) {
      print("Provider error (getAll): $e");
      rethrow;
    }
  }

  // Future<DocumentSnapshot<Map<String, dynamic>>> getById(
  //     shoppingListId, itemId) async {
  //   try {
  //     final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
  //         .collection(shoppingListCollection)
  //         .doc(shoppingListId)
  //         .collection(itemCollection)
  //         .doc(itemId)
  //         .get();

  //     print("Data retrieved successfully (getById): $snapshot");

  //     return snapshot;
  //   } catch (e) {
  //     print("Provider error (getById): $e");
  //     rethrow;
  //   }
  // }

  edit(obj) {}

  Future<ItemModel> addItem(String shoppingListId, ItemModel item) async {
    try {
      // Get a reference to the collection you want to add data to
      final collectionRef = FirebaseFirestore.instance
          .collection(shoppingListCollection)
          .doc(shoppingListId)
          .collection(itemCollection);

      // Create a new document with auto-generated ID
      final newDocRef = await collectionRef.add(item.toJson());
      // Assign the newly created id
      item.id = newDocRef.id;

      print("Item added successfully (addItem): $item");

      return item;
    } catch (e) {
      print("Provider error (addItem): $e");
      rethrow;
    }
  }

  Future<String?> uploadImage(XFile? file) async {
    if (file == null) return null;

    // Create a reference to the file location
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final storageRef =
        FirebaseStorage.instance.ref().child(imageCollection + fileName);

    // Upload the file to the storage location
    final uploadTask = storageRef.putFile(File(file.path));

    // Wait for the upload to complete and return the download URL
    final snapshot = await uploadTask;
    final downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<ItemModel> addItemOverview(String shoppingListId, ItemModel item) async {
    try {
      // Get a reference to the collection you want to add data to
      final collectionRef = FirebaseFirestore.instance
          .collection(shoppingListCollection)
          .doc(shoppingListId)
          .collection(itemCollection);

      // Create a new document with auto-generated ID
      
      final newDocRef = await collectionRef.add(item.toJson());
      // Assign the newly created id
      item.id = newDocRef.id;

      print("Item added successfully (addItem): $item");

      return item;
    } catch (e) {
      print("Provider error (addItem): $e");
      rethrow;
    }
  }

  deleteItem(String shoppingListId,ItemModel item) async {
    await FirebaseFirestore.instance
        .collection("ShoppingList")
        .doc(shoppingListId)
        .collection("Item")
        .doc(item.id)
        .delete();
  }

  updateItem(String uid, ItemModel item) {
    final collectionRef = _firestore
        .collection("ShoppingList")
        .doc(uid)
        .collection("Item")
        .doc(item.id)
        .set(item.toJson());
  }
  
}
