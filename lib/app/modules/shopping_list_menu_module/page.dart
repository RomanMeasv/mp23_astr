import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/item_module/binding.dart';
import 'package:mp23_astr/app/modules/user_module/controller.dart';

import '../../data/model/shopping_list_menu.dart';
import '../item_module/page.dart';
import '../shopping_list_menu_module/controller.dart';

class ShoppingListMenuPage extends GetView<ShoppingListMenuController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return showBottomSheet(context, false, ShoppingListMenuModel());
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Current Shopping Lists'),
          centerTitle: true,
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: controller.rxShoppingLists.value.length,
            itemBuilder: (context, int index) {
              return ListTile(
                title: Text(controller.rxShoppingLists.value[index].name),
                onTap: () {
                  controller.selectedShoppingList =
                      controller.rxShoppingLists.value[index];
                  Get.to(() => ItemPage(), binding: ItemBinding());
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return showBottomSheet(context, true,
                                controller.rxShoppingLists.value[index]);
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                      ),
                      onPressed: () {
                        controller.deleteShoppingList(
                            controller.rxShoppingLists.value[index]);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }

  String? value;
  Widget showBottomSheet(
      BuildContext context, bool isUpdate, ShoppingListMenuModel shoppingList) {
    // Added the isUpdate argument to check if our item has been updated
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                // Used a ternary operator to check if isUpdate is true then display
                // Update Todo.
                labelText:
                    isUpdate ? 'Update Shopping List' : 'Add Shopping List',
                hintText: 'Enter a Shopping list',
              ),
              onChanged: (String _val) {
                // Storing the value of the text entered in the variable value.
                value = _val;
              },
            ),
          ),
          TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.lightBlueAccent),
              ),
              onPressed: () {
                // Check to see if isUpdate is true then update the value else add the value
                if (isUpdate) {
                  shoppingList.name = value;
                  controller.updateShoppingList(shoppingList.uid, shoppingList);
                } else {
                  if (value != null) {
                    controller.add(value!);
                  }
                }
                Navigator.pop(context);
              },
              child: isUpdate
                  ? const Text(
                      'UPDATE',
                      style: TextStyle(color: Colors.white),
                    )
                  : const Text('ADD', style: TextStyle(color: Colors.white))),
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
        title: Text(list[index].toString()),
      );
    },
    itemCount: list.length,
  );
}
