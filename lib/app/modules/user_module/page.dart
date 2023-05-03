import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class UserPage extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('UserPage')),
      body: Column(
        children: [
          Text('UserPage is working!'),
          ElevatedButton(
            onPressed: () => controller.signUp("asd123@asd.com", "asd123"),
            child: Text("Sign up"),
          ),
          //TODO: Display the user's email
        ],
      ),
    );
  }
}
