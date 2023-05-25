import 'package:mp23_astr/app/data/model/shopping_list_menu.dart';
import 'package:mp23_astr/app/data/provider/shopping_list_menu_provider.dart';

class ShoppingListMenuRepository {
  final ShoppingListMenuProvider shoppingListMenuProvider;

  ShoppingListMenuRepository(this.shoppingListMenuProvider);

  Future<List<ShoppingListMenuModel>> getAll(
      List<String> shoppingListIDs) async {
    return await shoppingListMenuProvider.getAll(shoppingListIDs);
  }

  // Future<ShoppingListMenuModel> getId(id) async {
  //   ShoppingListMenuModel shoppingList =
  //       await shoppingListMenuProvider.getById(id);
  //   return shoppingList;
  // }

  delete(String userID,ShoppingListMenuModel shoppingList) {
    return shoppingListMenuProvider.deleteShoppingList(userID,shoppingList);
  }

  Future<ShoppingListMenuModel> edit(
      String ID, ShoppingListMenuModel shoppingList) async {
    final updatedShoppingList =
        await shoppingListMenuProvider.updateShoppingList(ID, shoppingList);
    return updatedShoppingList;
  }

  Future<ShoppingListMenuModel> add(ShoppingListMenuModel shoppingList) async {
    final addedShoppingList =
        await shoppingListMenuProvider.addShoppingList(shoppingList);
    return addedShoppingList;
  }
}
