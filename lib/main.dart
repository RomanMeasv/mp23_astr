import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mp23_astr/app/modules/item_module/binding.dart';
import 'package:mp23_astr/app/modules/item_module/page.dart';
import 'package:mp23_astr/app/modules/user_module/binding.dart';
import 'package:mp23_astr/app/modules/user_module/page.dart';
import 'package:get/get.dart';

import 'app/routes/pages.dart';
import 'app/routes/routes.dart';
import 'core/theme/theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.clearPersistence();
  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const Mp23Astr());
}

class Mp23Astr extends StatelessWidget {
  const Mp23Astr({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: Routes.ITEM,
      theme: appThemeData,
      defaultTransition: Transition.fade,
      initialBinding: ItemBinding(),
      getPages: AppPages.pages,
      home: ItemPage(),
    );
  }
}
