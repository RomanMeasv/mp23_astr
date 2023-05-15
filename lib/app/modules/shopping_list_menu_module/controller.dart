import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/shopping_list_menu_module/repository.dart';
import 'package:mp23_astr/app/modules/user_module/repository.dart';

import '../../data/model/shopping_list_menu.dart';
import '../../data/model/user.dart';
import '../user_module/auth_repository.dart';
import '../user_module/controller.dart';

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
    print("ShoppingLIstUser: ${shoppingListIDs}");
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
    ShoppingListMenuModel shoppingList = ShoppingListMenuModel();
    shoppingList.name = name;
    shoppingList.owner = userController.rxUserModel.uid;
    shoppingList = await repository.add(shoppingList);
    userController.assignShoppingList(shoppingList.uid);
    rxShoppingLists.value.add(shoppingList);
    print("Added Shopping List ${shoppingList.uid}");
  }

  // Future<ShoppingListMenuModel> getById(String shoppingListID) async {
  //   return repository.getId(shoppingListID);
  // }
  deleteShoppingList(ShoppingListMenuModel shoppingList) async {
    //userController.deAssignShoppingList(shoppingList.uid);

    userController.rxUserModel.removeShoppingListId(shoppingList.uid);

    await repository.delete(userController.rxUserModel.uid,shoppingList);
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
