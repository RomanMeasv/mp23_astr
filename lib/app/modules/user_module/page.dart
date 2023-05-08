import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/user_module/widgets/login_widget.dart';

import 'controller.dart';

class UserPage extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UserPage')),
      body: Column(
        children: [
          Obx(() => Text('UID: ${controller.user.uid}')),
          Obx(() => Text('Email: ${controller.user.email}')),
          Obx(() => Text('ShoppingListIds: ${controller.user.shoppingListIds}')),
          LoginWidget(),
          ElevatedButton(
            onPressed: () => controller.signOut(),
            child: Text("Sign out"),
          ),
        ],
      ),
    );
  }
}
