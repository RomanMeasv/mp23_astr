import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RxShoppingListMenuModel {
  // final date = '0'.obs;
  // final name = 'name'.obs;
  // final id = '0'.obs;
  final RxMap<String, dynamic> _shoppinLists = <String, dynamic>{}.obs;
}

class ShoppingListMenuModel {
  // ShoppingListMenuModel({id, name, date}) {
  //   rx.name.value = name;
  //   rx.date.value = date;
  //   rx.id.value = id;
  // }
  ShoppingListMenuModel();
  final rx = RxShoppingListMenuModel();

  // get id => rx.id.value;
  // set id(value) => rx.id.value = value;

  // get name => rx.name.value;
  // set name(value) => rx.name.value = value;

  // get date => rx.date.value;
  // set date(value) => rx.date.value = value;
  Map<String, dynamic> get shoppingLists => rx._shoppinLists.value;
  set shoppingLists(value) => rx._shoppinLists.value = value;
  ShoppingListMenuModel.fromJson(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    docs.map((qds) {
      rx._shoppinLists.addAll(qds.data());
    });
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.shoppingLists;
   // data['date'] = this.imageUrl;
    return data;
  }
}
