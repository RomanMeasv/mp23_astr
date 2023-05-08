import 'package:get/get.dart';
import 'package:mp23_astr/app/data/provider/auth_provider.dart';
import 'package:mp23_astr/app/modules/shopping_list_menu_module/controller.dart';
import 'package:mp23_astr/app/modules/shopping_list_menu_module/repository.dart';
import 'package:mp23_astr/app/modules/user_module/auth_repository.dart';


import '../../data/provider/shopping_list_menu_provider.dart';

class ShoppingListMenuBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ShoppingListMenuController>(
    () => ShoppingListMenuController(ShoppingListMenuRepository(ShoppingListMenuProvider())));
  }
}