import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shopping_list_module/controller.dart';

class ShoppingListMenuPage extends GetView<ShoppingListController> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: Text('ShoppingListMenuPage')),

    body: SafeArea(
      child: Text('ShoppingListMenuController'))
    );
  }
}