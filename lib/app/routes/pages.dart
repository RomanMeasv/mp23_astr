import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/shopping_list_module/page.dart';
import 'package:mp23_astr/app/modules/user_module/page.dart';
import 'package:mp23_astr/app/routes/routes.dart';

import '../modules/item_module/page.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.ITEM, page: () => ItemPage()),
    GetPage(name: Routes.SHOPPING_LIST, page: () => ShoppingListPage()),
    GetPage(name: Routes.USER, page: () => UserPage()),
  ];
}
