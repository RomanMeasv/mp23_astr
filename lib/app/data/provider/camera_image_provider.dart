import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/data/model/item.dart';

class CameraImageProvider extends GetConnect {
  final shoppingListsCollection = "ShoppingLists";
  final itemsCollection = "Items";
  final imageCollection = "Images";

  Future<String?> uploadImage(XFile file) async {
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

  Future<void> addImageUrlToItem(
      String shoppingListId, ItemModel item, String imageUrl) async {
    try {
      // add imageUrl field to the item stored in firestore
      await FirebaseFirestore.instance
          .collection(shoppingListsCollection)
          .doc(shoppingListId)
          .collection(itemsCollection)
          .doc(item.id)
          .update(item.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
