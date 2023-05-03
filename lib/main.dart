import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/item_module/binding.dart';
import 'package:mp23_astr/app/modules/item_module/page.dart';
import 'package:mp23_astr/app/modules/user_module/binding.dart';
import 'package:mp23_astr/app/modules/user_module/page.dart';

import 'app/routes/pages.dart';
import 'app/routes/routes.dart';
import 'core/theme/theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      initialBinding: UserBinding(),
      getPages: AppPages.pages,
      home: UserPage(),
    );
  }
}
