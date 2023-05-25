import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RxUserModel {
  final uid = ''.obs;
  final email = ''.obs;
  final shoppingListIds = <String>[].obs;
}

class UserModel {
  UserModel({uid, email});

  final rx = RxUserModel();

  get uid => rx.uid.value;
  set uid(value) => rx.uid.value = value;

  get email => rx.email.value;
  set email(value) => rx.email.value = value;

  get shoppingListIds => rx.shoppingListIds;
  set shoppingListIds(value) => rx.shoppingListIds.value = value;

  void removeShoppingListId(String shoppingListId) {
    rx.shoppingListIds.remove(shoppingListId);
    
  }
  UserModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    uid = snapshot.id;
    email = snapshot.data()!['email'];
    shoppingListIds = List<String>.from(snapshot.data()!['shoppingListIds']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['email'] = email;
    data['shoppingListIds'] = shoppingListIds;
    return data;
  }

  reset() {
    uid = "";
    email = "";
    shoppingListIds = <String>[];
  }
}