import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth_module/controller.dart';

class UserPage extends GetView<UserController> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: Text('UserPage')),

    body: SafeArea(
      child: Text('UserController'))
    );
  }
}