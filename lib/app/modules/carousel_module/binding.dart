import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/carousel_module/controller.dart';

class CarouselBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarouselController>(
      () => CarouselController(),
    );
  }
}
