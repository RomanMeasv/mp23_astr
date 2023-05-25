import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RxShoppingListMenuModel {
  final uid = "".obs;
  final name = "".obs;
  final owner = "".obs;
  final itemCount = 0.obs;
}

class ShoppingListMenuModel {
  ShoppingListMenuModel();
  final rx = RxShoppingListMenuModel();

  String get uid => rx.uid.value;
  set uid(value) => rx.uid.value = value;

  String get name => rx.name.value;
  set name(value) => rx.name.value = value;

  String get owner => rx.owner.value;
  set owner(value) => rx.owner.value = value;

  int get itemCount => rx.itemCount.value;
  set itemCount(value) => rx.itemCount.value = value;

  ShoppingListMenuModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    uid = snapshot.id;
    name = snapshot.data()!['name'] ?? "";
    owner = snapshot.data()!['owner'] ?? "";
    
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    
    return data;
  }
}
