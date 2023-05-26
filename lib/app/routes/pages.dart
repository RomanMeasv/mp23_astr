import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/camera_module/page.dart';
import 'package:mp23_astr/app/modules/carousel_module/page.dart';
import 'package:mp23_astr/app/modules/item_overview_module/page.dart';
import 'package:mp23_astr/app/modules/shopping_list_menu_module/page.dart';
import 'package:mp23_astr/app/modules/user_module/page.dart';
import 'package:mp23_astr/app/routes/routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.USER, page: () => UserPage()),
    GetPage(
        name: Routes.SHOPPING_LIST_MENU, page: () => ShoppingListMenuPage()),
    GetPage(name: Routes.ITEM_OVERVIEW, page: () => ItemOverviewPage()),
    GetPage(name: Routes.CAMERA, page: () => CameraPage()),
    GetPage(name: Routes.CAROUSEL, page: () => CarouselPage()),
  ];
}
