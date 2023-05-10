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
    bool _obscureText = true;

    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 50)),
        Image.asset('lib/app/assets/images/grocery.png', scale: 3),
        Text('Unpacked',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                )),
                        const Padding(padding: EdgeInsets.only(top: 30)),

        Container(
          margin: const EdgeInsets.all(20),
          child: TextField(
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
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: '••••••••',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
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
                obscureText: _obscureText,
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
                  controller.signIn(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text('Log in',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary
                        )
                        ),
              ),
            )),
            
        Container(
            height: 60,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
            child: SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  controller.signUp(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text('Register',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary)),
              ),
            ))
      ],
    );
  }
}
