import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/data/model/user.dart';
import 'package:mp23_astr/app/modules/user_module/widgets/login_widget.dart';
import 'package:mp23_astr/app/modules/user_module/widgets/register_widget.dart';

import 'controller.dart';

class UserPage extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (controller.isLogging.value == false) {
                return RegisterWidget();
              } else {
                return LoginWidget();
              }
            }),
          ],
        ),
      ),
    );
  }
}