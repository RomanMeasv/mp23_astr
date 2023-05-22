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
  addItem(String shoppingListId, ItemModel item) {
    return api.addItemOverview(shoppingListId, item);
  }

  Future<List<ItemModel>> getAll(String shoppingListId) async {
    return await api.getAllItems(shoppingListId);
  }

  void deleteItem(String shoppingListId, ItemModel item) async {
    await api.deleteItem(shoppingListId, item);
  }

  void updateItem(String shoppingListId, ItemModel item) async {
    await api.updateItem(shoppingListId, item);
  }
}
