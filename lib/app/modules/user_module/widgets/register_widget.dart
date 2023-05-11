import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class RegisterWidget extends StatefulWidget {
  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.find();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(padding: EdgeInsets.only(top: 50)),
        Text('Register in Unpacked',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              )),
        const Padding(padding: EdgeInsets.only(top: 30)),
        
      ],
    );
  }
}
