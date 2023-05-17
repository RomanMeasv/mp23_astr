import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RxShoppingListMenuModel {
  final uid = "".obs;
  final name = "".obs;
  final owner = "".obs;
  final members = <String>[].obs;
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

  List<String> get members => rx.members;
  set members(value) => rx.members.value = value;

  ShoppingListMenuModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    uid = snapshot.id;
    name = snapshot.data()!['name'] ?? "";
    owner = snapshot.data()!['owner'] ?? "";
    members.addAll(snapshot.data()!['members'] ?? []);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    // data['uid'] = uid;
    data['name'] = name;
    data['owner'] = owner;
    data['members'] = members.toList();
    return data;
  }
}
