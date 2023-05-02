import 'package:get/get.dart';
import 'package:mp23_astr/app/data/provider/item_provider.dart';
import 'package:mp23_astr/app/modules/item_module/repository.dart';

import 'controller.dart';

class ItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemController>(
        () => ItemController(ItemRepository(ItemApi())));
  }
}
