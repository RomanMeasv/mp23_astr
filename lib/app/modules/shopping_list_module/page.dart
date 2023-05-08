import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/user_module/controller.dart';

import 'controller.dart';

class ShoppingListPage extends GetView<ShoppingListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ShoppingListPage')),
    );
  }
}
