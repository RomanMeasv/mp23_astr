import 'package:mp23_astr/app/data/model/shopping_list_menu.dart';
import 'package:mp23_astr/app/data/provider/shopping_list_menu_provider.dart';

class ShoppingListMenuRepository {
  final ShoppingListMenuProvider shoppingListMenuProvider;

  ShoppingListMenuRepository(this.shoppingListMenuProvider);

  Future<List<ShoppingListMenuModel>> getAll() async {
    List<ShoppingListMenuModel> AllShoppingLists =
        await shoppingListMenuProvider.getAll();
    return AllShoppingLists;
  }

  Future<ShoppingListMenuModel> getId(id) async {
    ShoppingListMenuModel shoppingList =
        await shoppingListMenuProvider.getById(id);
    return shoppingList;
  }

  delete(id) {
    return shoppingListMenuProvider.delete(id);
  }

  Future<ShoppingListMenuModel> edit(String ID,ShoppingListMenuModel shoppingList) async {
    ShoppingListMenuModel UpdatedShoppingList = await shoppingListMenuProvider.updateShoppingList(ID,shoppingList);
    return UpdatedShoppingList; 
  }

  Future<ShoppingListMenuModel> add(String nameGiven, String dateGiven) async {
    ShoppingListMenuModel shoppingList =
        ShoppingListMenuModel(id: "", name: nameGiven, date: dateGiven);
    ShoppingListMenuModel createdShoppingList =
        await shoppingListMenuProvider.addShoppingList(shoppingList);
    return createdShoppingList;
  }
}
