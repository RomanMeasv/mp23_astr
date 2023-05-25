import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_connect/connect.dart';
import 'package:mp23_astr/app/data/model/item.dart';

class ItemProvider extends GetConnect {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final shoppingListsCollection = "ShoppingLists";
  final itemsCollection = "Items";
  final imageCollection = "Images";

  Future<List<ItemModel>> getAllItems(shoppingListId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection(shoppingListsCollection)
          .doc(shoppingListId)
          .collection(itemsCollection)
          .get();

      final List<ItemModel> items = snapshot.docs
          .map((item) => ItemModel.fromJson(item.id, item.data()))
          .toList();

      return items;
    } catch (e) {
      rethrow;
    }
  }

  Future<ItemModel> addItem(String shoppingListId, ItemModel item) async {
    try {
      // Get a reference to the collection you want to add data to
      final collectionRef = FirebaseFirestore.instance
          .collection(shoppingListsCollection)
          .doc(shoppingListId)
          .collection(itemsCollection);

      // Create a new document with auto-generated ID
      final newDocRef = await collectionRef.add(item.toJson());
      // Assign the newly created id
      item.id = newDocRef.id;

      return item;
    } catch (e) {
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

  Future<ItemModel> addItemOverview(
      String shoppingListId, ItemModel item) async {
    try {
      // Get a reference to the collection you want to add data to
      final collectionRef = FirebaseFirestore.instance
          .collection(shoppingListsCollection)
          .doc(shoppingListId)
          .collection(itemsCollection);

      // Create a new document with auto-generated ID

      final newDocRef = await collectionRef.add(item.toJson());
      // Assign the newly created id
      item.id = newDocRef.id;

      return item;
    } catch (e) {
      rethrow;
    }
  }

  deleteItem(String shoppingListId, ItemModel item) async {
    await FirebaseFirestore.instance
        .collection(shoppingListsCollection)
        .doc(shoppingListId)
        .collection(itemsCollection)
        .doc(item.id)
        .delete();
  }

  updateItem(String shoppingListId, ItemModel item) {
    _firestore
        .collection(shoppingListsCollection)
        .doc(shoppingListId)
        .collection(itemsCollection)
        .doc(item.id)
        .set(item.toJson());
  }
}
