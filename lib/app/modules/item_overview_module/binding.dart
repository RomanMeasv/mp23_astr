import 'package:get/get.dart';
import 'package:mp23_astr/app/data/provider/item_provider.dart';
import 'package:mp23_astr/app/modules/item_overview_module/controller.dart';
import 'package:mp23_astr/app/modules/item_overview_module/repository.dart';

class ItemOverviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ItemOverviewController>(
      ItemOverviewController(
        ItemOverviewRepository(
          ItemProvider(),
        ),
      ),
    );
  }
}
