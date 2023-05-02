import 'package:get/get.dart';
import 'package:mp23_astr/app/routes/routes.dart';

import '../modules/item_module/page.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.ITEM, page: () => ItemPage())
  ];
}
