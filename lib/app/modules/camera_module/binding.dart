import 'package:get/get.dart';
import 'package:mp23_astr/app/data/provider/item_provider.dart';
import 'package:mp23_astr/app/modules/camera_module/controller.dart';
import 'package:mp23_astr/app/modules/camera_module/repository.dart';

class CameraBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraPageController>(
        () => CameraPageController(CameraRepository(ItemProvider())));
  }
}
