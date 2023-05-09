import 'package:camera/camera.dart';
import 'package:mp23_astr/app/data/model/item.dart';

import 'package:mp23_astr/app/data/provider/item_provider.dart';

class ItemRepository {
  final ItemProvider api;
  late ItemModel model;

  ItemRepository(this.api);

  getAll(String shoppingListId) async {
    model = await api.getAll(shoppingListId);
  }

  addItem(String shoppingListId, String text, XFile image) async {
    String? imageUrl = await api.uploadImage(image);
    if (imageUrl == null) throw Exception("Image not uploaded");

    final Map<String, dynamic> item = <String, dynamic>{
      "text": text,
      "imageUrl": imageUrl
    };

    final addedItem = await api.addItem(shoppingListId, item);
    model.items.addAll(addedItem);
  }

  // getById(String shoppingListId, String itemId) {
  //   return api.getById(shoppingListId, itemId);
  // }

  delete(id) {
    return api.delete(id);
  }

  edit(obj) {
    return api.edit(obj);
  }
}
