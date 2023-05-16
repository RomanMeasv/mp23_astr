import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_connect/connect.dart';
import 'package:mp23_astr/app/data/model/item.dart';

class ItemProvider extends GetConnect {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final shoppingListCollection = "ShoppingLists";
  final itemCollection = "Items";
  final imageCollection = "Images";

  Future<List<ItemModel>> getAllItems(shoppingListId) async {
    try {
      // points to the item collection
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection(shoppingListCollection)
          .doc(shoppingListId)
          .collection(itemCollection)
          .get();

      // if the collection is empty, return an empty list
      if (snapshot.docs.isEmpty) return List<ItemModel>.empty(growable: true);

      // since there are items in the collection, map them to a list
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

  Future<ItemModel> addItem(String shoppingListId, ItemModel itemToAdd) async {
    try {
      // upload the image to FireStorage first
      itemToAdd = await uploadImage(itemToAdd);

      // points to the item collection
      final collectionRef = FirebaseFirestore.instance
          .collection(shoppingListCollection)
          .doc(shoppingListId)
          .collection(itemCollection);

      // creates a new document inside the collection (return is the created document)
      final newDocRef = await collectionRef.add(itemToAdd.toJson());
      // assign id to the item
      itemToAdd.id = newDocRef.id;

      print("Item added successfully (addItem): $itemToAdd");

      return itemToAdd;
    } catch (e) {
      print("Provider error (addItem): $e");
      rethrow;
    }
  }

  Future<ItemModel> uploadImage(ItemModel item) async {
    // Create a reference to the file location
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final storageRef =
        FirebaseStorage.instance.ref(imageCollection).child(fileName);

    // Upload the file to the storage location
    final uploadTask = storageRef.putFile(File(item.image.path));

    // Wait for the upload to complete and return the download URL
    final snapshot = await uploadTask;
    final downloadURL = await snapshot.ref.getDownloadURL();

    item.imageUrl = downloadURL;
    item.imagePath = fileName;
    return item;
  }

  Future<void> deleteItem(String shoppingListId, ItemModel item) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref(imageCollection).child(item.imagePath);
      await storageRef.delete();

      // points to the item doc
      final itemRef = FirebaseFirestore.instance
          .collection(shoppingListCollection)
          .doc(shoppingListId)
          .collection(itemCollection)
          .doc(item.id);

      await itemRef.delete();
    } catch (e) {
      print("Provider error (deleteItem): $e");
      rethrow;
    }
  }
}
