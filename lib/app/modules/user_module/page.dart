import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class UserPage extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.find();

    return Scaffold(
      appBar: AppBar(title: Text('UserPage')),
      body: Column(
        children: [
          Text('UserPage is working!'),
          Obx(() => Text('User: ${controller.user.email}')),
          ElevatedButton(
            onPressed: () => controller.signUp("asd123@asd.com", "asd123"),
            child: Text("Sign up"),
          ),
          ElevatedButton(
            onPressed: () => controller.signIn("asd123@asd.com", "asd123"),
            child: Text("Sign in"),
          ),
          ElevatedButton(
            onPressed: () => controller.signOut(),
            child: Text("Sign out"),
          ),
        ],
      ),
    );
  }
}
