import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ShoppingListPage extends GetView<ShoppingListController> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: Text('ShoppingListPage')),

    body: SafeArea(
      child: Text('ShoppingListController'))
    );
  }
}