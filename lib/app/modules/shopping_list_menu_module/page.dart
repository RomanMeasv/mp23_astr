import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/user_module/controller.dart';

import '../../data/model/shopping_list_menu.dart';
import '../shopping_list_menu_module/controller.dart';

class ShoppingListMenuPage extends GetView<ShoppingListMenuController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ShoppingListMenuPage')),
      body: Column(
        children: [
          Text('Shopping List page is working!'),
          ElevatedButton(
            onPressed: () => controller.getAll(),
            child: Text("View ShoppingLists"),
          ),
          ElevatedButton(
            onPressed: () => controller.add("Tawfik test", "22/02/1999"),
            child: Text("Add a ShoppingList"),
          ),
          ElevatedButton(
            onPressed: () => controller.getById("OfwoYr2jeCBDrp4FRAVc"),
            child: Text("Get By ID"),
          ),
          ElevatedButton(
            onPressed: () => controller.updateShoppingList(
                "oMytU3WlFqehQcz8mwSi",
                ShoppingListMenuModel(
                    name: "Modified Shit", date: "12/2/5255")),
            child: Text("Update List"),
          ),
        ],
      ),
    );
  }
}

Widget _buildShoppingList(
    BuildContext context, List<ShoppingListMenuModel> list) {
  return ListView.builder(
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text(list[index].name),
      );
    },
    itemCount: list.length,
  );
}
