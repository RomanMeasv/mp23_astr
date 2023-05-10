import 'package:mp23_astr/app/data/model/shopping_list_menu.dart';
import 'package:mp23_astr/app/data/provider/shopping_list_menu_provider.dart';

class ShoppingListMenuRepository {
  final ShoppingListMenuProvider shoppingListMenuProvider;
 
  ShoppingListMenuRepository(this.shoppingListMenuProvider);

   Future<ShoppingListMenuModel> getAll(List<String> shoppingListIDs) async {
    return await shoppingListMenuProvider.getAll(shoppingListIDs);
  }

  // Future<ShoppingListMenuModel> getId(id) async {
  //   ShoppingListMenuModel shoppingList =
  //       await shoppingListMenuProvider.getById(id);
  //   return shoppingList;
  // }

  delete(id) {
    return shoppingListMenuProvider.delete(id);
  }

  // Future<ShoppingListMenuModel> edit(
  //     String ID, ShoppingListMenuModel shoppingList) async {
  //   final updatedShoppinList =
  //       await shoppingListMenuProvider.updateShoppingList(ID, shoppingList);
  //   return UpdatedShoppingList;
  // }

  add(String name, String date) async {
    final Map<String, dynamic> shoppingList = <String, dynamic>{
      "name": name,
      "date": date
    };
    final addedShoppingList =
        await shoppingListMenuProvider.addShoppingList(shoppingList);
    
  }
}
