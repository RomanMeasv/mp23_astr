import 'package:mp23_astr/app/data/provider/item_provider.dart';

import '../../data/model/item.dart';

class ItemOverviewRepository {
  final ItemProvider api;

  ItemOverviewRepository(this.api);

  Future<List<ItemModel>> getAllItems(String shoppingListId) async {
    return api.getAllItems(shoppingListId);
  }

// getId(id){
//   return api.getId(id);
// }
// delete(id){
//   return api.delete(id);
// }
// edit(obj){
//   return api.edit( obj );
// }
  addItem(String shoppingListId, String itemName) {
    ItemModel item = ItemModel(text: itemName, imageUrl: "");
    item.bought = false;
    return api.addItemOverview(shoppingListId, item);
  }

  Future<List<ItemModel>> getAll(String shoppingListId) async {
    return await api.getAllItems(shoppingListId);
  }

  void deleteItem(String shoppingListId, ItemModel item) async {
    await api.deleteItem(shoppingListId, item);
  }

  void updateItem(String uid, ItemModel item) async {
    await api.updateItem(uid, item);
  }
}
