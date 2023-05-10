import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/shopping_list_menu_module/repository.dart';

import '../../data/model/shopping_list_menu.dart';
import '../user_module/auth_repository.dart';
import '../user_module/controller.dart';

class ShoppingListMenuController extends GetxController {
  final ShoppingListMenuRepository repository;
  UserController userController = Get.find<UserController>();

  Rx<List<ShoppingListMenuModel>> rxShoppingLists =
      Rx<List<ShoppingListMenuModel>>([]);
  ShoppingListMenuModel selectedShoppingList = ShoppingListMenuModel();
  ShoppingListMenuController(this.repository) {
    // getAll();
  }

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
    print("Controller: ${rxShoppingLists.value.length}");
  }
  // final _shoppingLists = Map<String, dynamic>{};
  // get shoppingLists => _shoppingLists.value;
  // set shoppingLists(value) => _shoppingLists.value = value;
  // get shoppingListsCount => shoppingLists.length;

  add(String name) async {
    ShoppingListMenuModel shoppingList = await repository.add(name);
    userController.assignShoppingList(shoppingList.uid);
    rxShoppingLists.value.add(shoppingList);
    print("Added Shopping List ${shoppingList.uid}");
  }

  // Future<ShoppingListMenuModel> getById(String shoppingListID) async {
  //   return repository.getId(shoppingListID);
  // }
  deleteShoppingList(ShoppingListMenuModel shoppingList) async {
    userController.deAssignShoppingList(shoppingList.uid);
    await repository.delete(shoppingList.uid);
    getAll();
  }

  updateShoppingList(String ID, ShoppingListMenuModel shoppingList) async {
    // rxShoppingLists.value.remove(shoppingList);
    ShoppingListMenuModel shoppingListUpdated =
        await repository.edit(ID, shoppingList);
    // rxShoppingLists.value.add(shoppingListUpdated);
    getAll();
    print("Modified ${shoppingList.name}");
  }
  // final _obj = ''.obs;
  // set obj(value) => this._obj.value = value;
  // get obj => this._obj.value;
}
