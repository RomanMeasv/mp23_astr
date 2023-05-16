import 'package:mp23_astr/app/data/model/item.dart';

import 'package:mp23_astr/app/data/provider/item_provider.dart';

class ItemRepository {
  final ItemProvider api;
  late List<ItemModel> items;

  ItemRepository(this.api);

  Future<List<ItemModel>> getAll(String shoppingListId) async {
    return items = await api.getAllItems(shoppingListId);
  }

  Future<List<ItemModel>> addItem(
      String shoppingListId, ItemModel itemToAdd) async {
    // add the item to FireStore and if it's successfull, add it to repository
    final ItemModel addedItem = await api.addItem(shoppingListId, itemToAdd);
    items.add(addedItem);
    return items;
  }

  // getById(String shoppingListId, String itemId) {
  //   return api.getById(shoppingListId, itemId);
  // }

  Future<List<ItemModel>> delete(
      String shoppingListId, ItemModel itemToDelete) async {
    await api.deleteItem(shoppingListId, itemToDelete);
    items.remove(itemToDelete);
    return items;
  }

  edit(obj) {
    return api.edit(obj);
  }
}
