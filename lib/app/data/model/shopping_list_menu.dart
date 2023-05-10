import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RxShoppingListMenuModel {

  final RxMap<String, dynamic> _shoppinLists = <String, dynamic>{}.obs;
}

class ShoppingListMenuModel {
  ShoppingListMenuModel();
  final rx = RxShoppingListMenuModel();

  Map<String, dynamic> get shoppingLists => rx._shoppinLists.value;
  set shoppingLists(value) => rx._shoppinLists.value = value;

  ShoppingListMenuModel.fromJson(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    // ignore: unused_local_variable
    for (int i = 0; i < docs.length; i++) {
      rx._shoppinLists.addAll(docs[i].data());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.shoppingLists;
    // data['date'] = this.imageUrl;
    return data;
  }
}
