import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/shopping_list_menu_module/repository.dart';

import 'package:mp23_astr/app/data/model/shopping_list_menu.dart';
import 'package:mp23_astr/app/data/model/user.dart';
import 'package:mp23_astr/app/modules/user_module/controller.dart';

class ShoppingListMenuController extends GetxController {
  final ShoppingListMenuRepository repository;
  UserController userController = Get.find<UserController>();

  // UserRepository userRepository = Get.find<UserRepository>();

  Rx<List<ShoppingListMenuModel>> rxShoppingLists =
      Rx<List<ShoppingListMenuModel>>([]);
  ShoppingListMenuModel selectedShoppingList = ShoppingListMenuModel();

  ShoppingListMenuController(this.repository) {
    // getAll();
  }

  List<UserModel> listUsers = <UserModel>[];

  @override
  void onInit() async {
    super.onInit();
    getAll();
  }

  void getAll() async {
    List<String> shoppingListIDs = userController.rxUserModel.shoppingListIds;
    List<ShoppingListMenuModel> shoppingList =
        await repository.getAll(shoppingListIDs);
    rxShoppingLists.value = List.from(shoppingList);
  }

  add(String name) async {
    ShoppingListMenuModel shoppingList = ShoppingListMenuModel();
    shoppingList.name = name;
    shoppingList.owner = userController.rxUserModel.uid;
    shoppingList = await repository.add(shoppingList);
    userController.assignShoppingList(shoppingList.uid);
    rxShoppingLists.value.add(shoppingList);
  }

  deleteShoppingList(ShoppingListMenuModel shoppingList) async {
    userController.rxUserModel.removeShoppingListId(shoppingList.uid);

    await repository.delete(userController.rxUserModel.uid, shoppingList);
    getAll();
  }

  updateShoppingList(String ID, ShoppingListMenuModel shoppingList) async {
    ShoppingListMenuModel shoppingListUpdated =
        await repository.edit(ID, shoppingList);
    getAll();
  }

  getAllUsers() async {
    listUsers = await userController.repository.getAll();
  }

  signOut() {
    userController.signOut();
  }

  addNewUserToShoppingList(
      String userID, ShoppingListMenuModel shoppingList) async {
    userController.repository.assignShoppingList(userID, shoppingList.uid);
  }
}
