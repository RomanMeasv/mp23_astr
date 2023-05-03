import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/item_module/binding.dart';
import 'package:mp23_astr/app/modules/item_module/page.dart';

import 'app/routes/pages.dart';
import 'app/routes/routes.dart';
import 'core/theme/theme.dart';

Future<void> main() async {
  runApp(const Mp23Astr());
}

class Mp23Astr extends StatelessWidget {
  const Mp23Astr({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.USER,
      theme: appThemeData,
      defaultTransition: Transition.fade,
      initialBinding: ItemBinding(),
      getPages: AppPages.pages,
      home: const ItemPage(),
    );
  }
}
