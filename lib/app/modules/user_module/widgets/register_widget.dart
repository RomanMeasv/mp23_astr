import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class RegisterWidget extends StatefulWidget {
  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final _validationFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();
  bool _obscureTextRepPass = true;
  bool _obscureTextPass = true;
  final UserController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _validationFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.only(top: 50)),
          Text('Register in Unpacked',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  )),
          const Padding(padding: EdgeInsets.only(top: 70)),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'example@gmail.com',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2.0,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              validator: (value) {
                if (value == null || value.isEmpty || !value.isEmail) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: '••••••••',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureTextPass
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureTextPass = !_obscureTextPass;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  obscureText: _obscureTextPass,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return TextFormField(
                  controller: _repeatPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Repeat password',
                    hintText: '••••••••',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureTextRepPass
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureTextRepPass = !_obscureTextRepPass;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  obscureText: _obscureTextRepPass,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return "Please repeat the previously introduced password";
                    }
                    if(value != _passwordController.value.text){
                      return "Password doesn't match";
                    }
                    return null;
                  },
                );
              },
            ),
          ),
          Container(
              height: 60,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    if (_validationFormKey.currentState!.validate()) {
                      controller.signUp(_emailController.text.trim(),
                          _passwordController.text.trim());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text('Register',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary)),
                ),
              )),
          Container(
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("or"),
                  ),
                  Expanded(
                      child: Divider(color: Colors.grey[400], thickness: 1)),
                ],
              )),
          Container(
              height: 60,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    //implement google log in
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text('Use your google account',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary)),
                ),
              )),
          Container(
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("or"),
                  ),
                  Expanded(
                      child: Divider(color: Colors.grey[400], thickness: 1)),
                ],
              )),
          Container(
              height: 60,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    controller.isLogging(true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text('Log in',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary)),
                ),
              )),
        ],
      ),
    );
  }
}
