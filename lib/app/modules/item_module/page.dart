import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ItemPage extends GetView<ItemController> {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ItemPage'),
      ),
      body: const SafeArea(
        child: Text('ItemController'),
      ),
    );
  }
}
