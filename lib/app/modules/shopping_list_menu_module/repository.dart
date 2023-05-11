import 'package:mp23_astr/app/data/model/shopping_list_menu.dart';
import 'package:mp23_astr/app/data/provider/shopping_list_menu_provider.dart';

import '../../data/model/user.dart';

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

  delete(id) {
    return shoppingListMenuProvider.deleteShoppingList(id);
  }

  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> listUsers = <UserModel>[];
    listUsers = await shoppingListMenuProvider.getAllUsers();
    return listUsers;
  }

  Future<ShoppingListMenuModel> edit(
      String ID, ShoppingListMenuModel shoppingList) async {
    print("IN REPO ${shoppingList.name}");
    final updatedShoppingList =
        await shoppingListMenuProvider.updateShoppingList(ID, shoppingList);
    return updatedShoppingList;
  }

  Future<ShoppingListMenuModel> add(String name) async {
    ShoppingListMenuModel shoppingList = ShoppingListMenuModel();
    shoppingList.name = name;
    final addedShoppingList =
        await shoppingListMenuProvider.addShoppingList(shoppingList);
    return addedShoppingList;
  }
}
