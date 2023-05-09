import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/user_module/controller.dart';

import '../../data/model/shopping_list_menu.dart';
import '../shopping_list_menu_module/controller.dart';

class ShoppingListMenuPage extends GetView<ShoppingListMenuController> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: Text('ShoppingListMenuPage')),
    //   body: Column(
    //     children: [
    //       Text('Shopping List page is working!'),
    //       ElevatedButton(
    //         onPressed: () => controller.getAll(),
    //         child: Text("View ShoppingLists"),
    //       ),
    //       ElevatedButton(
    //         onPressed: () => controller.add("Tawfik test", "22/02/1999"),
    //         child: Text("Add a ShoppingList"),
    //       ),
    //       ElevatedButton(
    //         onPressed: () => controller.getById("OfwoYr2jeCBDrp4FRAVc"),
    //         child: Text("Get By ID"),
    //       ),
    //       ElevatedButton(
    //         onPressed: () => controller.updateShoppingList(
    //             "oMytU3WlFqehQcz8mwSi",
    //             ShoppingListMenuModel(
    //                 name: "Modified Shit", date: "12/2/5255")),
    //         child: Text("Update List"),
    //       ),
    //     ],
    //   ),
    // );
    
    return Scaffold(
      bottomNavigationBar: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: showBottomSheet,
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Current Shopping Lists'),
        centerTitle: true,
      ),
      body: Obx(() =>  ListView.builder(
        itemCount: controller.shoppingLists.length,
        itemBuilder: (context, int index) {
          return ListTile(
            title: Text(controller.shoppingLists[index].toString()),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return showBottomSheet(context);
                },
              );
            },
            trailing: IconButton(
              icon: const Icon(
                Icons.delete_outline,
              ),
              onPressed: () {
                // Here We Will Add The Delete Feature
              },
            ),
          );
        },
      ),)
    );
  }


}

String? value;
Widget showBottomSheet(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Add Todo',
              hintText: 'Enter An Item',
            ),
            onChanged: (String _val) {
              value = _val;
            },
          ),
        ),
        TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.lightBlueAccent)),
            onPressed: () {
              // db.collection('todos').add({'todo': value});
              Navigator.pop(context);
            },
            child: const Text(
              'ADD',
              style: TextStyle(color: Colors.white),
            ))
      ],
    ),
  );
}

Widget _buildShoppingList(
    BuildContext context, List<ShoppingListMenuModel> list) {
  return ListView.builder(
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text(list[index].toString()),
      );
    },
    itemCount: list.length,
  );
}
