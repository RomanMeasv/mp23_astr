import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/shopping_list_menu_module/repository.dart';

import '../../data/model/shopping_list_menu.dart';
import '../user_module/auth_repository.dart';
import '../user_module/controller.dart';

class ShoppingListMenuController extends GetxController {
  final ShoppingListMenuRepository repository;
  UserController userController = Get.find<UserController>();
  ShoppingListMenuController(this.repository);

  getAll() {
    return repository.getAll();
  }

  Future<ShoppingListMenuModel> add(String name, String date) async {
    ShoppingListMenuModel shoppingList = await repository.add(name, date);
    userController.assignShoppingList(shoppingList.id);
    return shoppingList;
  }

  Future<ShoppingListMenuModel> getById(String shoppingListID) async {
    return repository.getId(shoppingListID);
  }

  Future<ShoppingListMenuModel> updateShoppingList(
      String ID, ShoppingListMenuModel shoppingList) {
    return repository.edit(ID, shoppingList);
  }
  // final _obj = ''.obs;
  // set obj(value) => this._obj.value = value;
  // get obj => this._obj.value;
}
