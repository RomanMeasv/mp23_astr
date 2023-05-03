import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/shopping_list_module/repository.dart';

import '../../data/provider/shopping_list_provider.dart';
import 'controller.dart';

class ShoppingListBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ShoppingListController>(() => ShoppingListController(
     ShoppingListRepository(ShoppingListProvider())));
  }
}