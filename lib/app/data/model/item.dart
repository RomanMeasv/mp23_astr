import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RxItemModel {
  final RxMap<String, dynamic> _items = <String, dynamic>{}.obs;
}

class ItemModel {
  ItemModel();

  final rx = RxItemModel();

  Map<String, dynamic> get items => rx._items.value;
  set items(value) => rx._items.value = value;

  ItemModel.fromJson(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    docs.map((qds) {
      rx._items.addAll(qds.data());
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = this.items;
    // data['imageUrl'] = this.imageUrl;
    return data;
  }
}
