import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/shopping_list_menu_module/repository.dart';

import '../../data/model/shopping_list_menu.dart';
import '../user_module/auth_repository.dart';
import '../user_module/controller.dart';

class ShoppingListMenuController extends GetxController {
  final ShoppingListMenuRepository repository;
  UserController userController = Get.find<UserController>();

  Rx<List<ShoppingListMenuModel>> rxShoppingLists = Rx<List<ShoppingListMenuModel>>([]);

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
    List<ShoppingListMenuModel> shoppingList = await repository.getAll(shoppingListIDs);
    rxShoppingLists.value = List.from(shoppingList);
    print("Controller: ${rxShoppingLists.value.length}");
  }
  // final _shoppingLists = Map<String, dynamic>{};
  // get shoppingLists => _shoppingLists.value;
  // set shoppingLists(value) => _shoppingLists.value = value;
  // get shoppingListsCount => shoppingLists.length;

  add(String name, String date) async {
    Map<String, dynamic> shoppingList = await repository.add(name, date);
    userController.assignShoppingList(shoppingList["id"]);
  }

  // Future<ShoppingListMenuModel> getById(String shoppingListID) async {
  //   return repository.getId(shoppingListID);
  // }

  // Future<ShoppingListMenuModel> updateShoppingList(
  //     String ID, ShoppingListMenuModel shoppingList) {
  //   return repository.edit(ID, shoppingList);
  // }
  // final _obj = ''.obs;
  // set obj(value) => this._obj.value = value;
  // get obj => this._obj.value;
}
