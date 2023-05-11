import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/item_module/repository.dart';
import 'package:mp23_astr/app/modules/shopping_list_menu_module/controller.dart';

class ItemController extends GetxController {
  final ItemRepository repository;
  ShoppingListMenuController shoppingListMenuController =
      Get.find<ShoppingListMenuController>();
  ItemController(this.repository);
  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
