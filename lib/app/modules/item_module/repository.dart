import 'package:camera/camera.dart';
import 'package:mp23_astr/app/data/model/item.dart';

import 'package:mp23_astr/app/data/provider/item_provider.dart';

class ItemRepository {
  final ItemProvider api;

  ItemRepository(this.api);

  Future<List<ItemModel>> getAll(String shoppingListId) async {
    return await api.getAllItems(shoppingListId);
  }

  Future<ItemModel> addItem(
      String shoppingListId, String text, XFile image) async {
    String? imageUrl = await api.uploadImage(image);
    if (imageUrl == null) throw Exception("Image not uploaded");

    final ItemModel item = ItemModel(text: text);

    return await api.addItem(shoppingListId, item);
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
