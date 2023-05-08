

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.find();

    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'Email'),
        ),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        ElevatedButton(
          onPressed: () => controller.signUp(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          ),
          child: Text("Sign up"),
        ),
        ElevatedButton(
          onPressed: () => controller.signIn(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          ),
          child: Text("Sign in"),
        ),
      ],
    );
  }
}