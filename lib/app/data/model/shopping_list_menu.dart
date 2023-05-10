import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RxShoppingListMenuModel {
  final uid = "".obs;
  final name = "".obs;
}

class ShoppingListMenuModel {
  ShoppingListMenuModel();
  final rx = RxShoppingListMenuModel();

  String get uid => rx.uid.value;
  set uid(value) => rx.uid.value = value;

  String get name => rx.name.value;
  set name(value) => rx.name.value = value;

  ShoppingListMenuModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    uid = snapshot.id;
    name = snapshot.data()!['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    return data;
  }
}
