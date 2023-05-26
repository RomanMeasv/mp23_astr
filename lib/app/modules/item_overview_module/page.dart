import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/camera_module/binding.dart';
import 'package:mp23_astr/app/modules/camera_module/page.dart';
import 'package:mp23_astr/app/modules/carousel_module/binding.dart';
import 'package:mp23_astr/app/modules/carousel_module/page.dart';
import 'package:mp23_astr/app/modules/item_overview_module/controller.dart';
import 'package:mp23_astr/app/modules/shopping_list_menu_module/controller.dart';
import 'package:mp23_astr/app/modules/user_module/controller.dart';

import 'package:mp23_astr/app/data/model/item.dart';

typedef ButtonCallback = void Function();

enum DialogType {
  delete,
  leave,
  user,
}

class ItemOverviewPage extends GetView<ItemOverviewController> {
  ShoppingListMenuController shoppingListMenuController =
      Get.find<ShoppingListMenuController>();
  UserController userController = Get.find<UserController>();

  ItemOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.shoppingListName),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.amp_stories),
              tooltip: 'Carousel',
              onPressed: () {
                Get.to(
                  CarouselPage(),
                  binding: CarouselBinding(),
                  arguments: {
                    "Items": controller.rxItemList,
                  },
                );
              }),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
        child: Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return showBottomSheet(context, false, ItemModel(text: ""));
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.rxItemList.value.length,
          itemBuilder: (context, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(CameraPage(), binding: CameraBinding(), arguments: {
                  "ShoppingListId": controller.shoppingListId,
                  "Item": controller.itemByIndex(index),
                });
              },
              child: Container(
                margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        controller.rxItemList.value[index].bought
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank_rounded,
                      ),
                      onPressed: () {
                        controller.buyItem(
                            shoppingListMenuController.selectedShoppingList.uid,
                            controller.rxItemList.value[index]);
                      },
                    ),
                    Expanded(
                      child: Text(controller.rxItemList.value[index].text,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.zero,
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                            ),
                            onPressed: () {
                              showDeleteAlertDialog(
                                  context, controller.rxItemList.value[index]);
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.zero,
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return showBottomSheet(context, true,
                                      controller.rxItemList.value[index]);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String? value;

  Widget showBottomSheet(BuildContext context, bool isUpdate, ItemModel item) {
    // Added the isUpdate argument to check if our item has been updated
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(
            isUpdate ? "Introduce a new name" : "Item name",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                // Used a ternary operator to check if isUpdate is true then display
                label: Text(isUpdate ? item.text : 'Enter an Item'),
              ),
              onChanged: (String val) {
                // Storing the value of the text entered in the variable value.
                value = val;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary),
                  ),
                  onPressed: () {
                    // Check to see if isUpdate is true then update the value else add the value
                    if (isUpdate) {
                      item.text = value!;
                      controller.updateItem(
                          controller.shoppingListMenuController
                              .selectedShoppingList.uid,
                          item);
                    } else {
                      if (value != null) {
                        controller.addItem(
                            shoppingListMenuController.selectedShoppingList.uid,
                            value!);
                      }
                    }
                    Navigator.pop(context);
                  },
                  child: isUpdate
                      ? const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text('Add',
                          style: TextStyle(color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }

  showConfirmationDialog({
    required BuildContext context,
    required DialogType type,
    required String title,
    required Widget content,
    required ButtonCallback cancelButtonCallback,
    required ButtonCallback continueButtonCallback,
  }) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      onPressed: cancelButtonCallback,
      child: const Text("Cancel"),
    );
    Widget continueButton = ElevatedButton(
      onPressed: continueButtonCallback,
      child: Text(
          type == DialogType.user ? "Add Shopping List to User" : "Continue"),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      content: content,
      actions: [
        cancelButton,
        continueButton,
      ],
      actionsAlignment: MainAxisAlignment.spaceEvenly,
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showDeleteAlertDialog(BuildContext context, ItemModel item) {
    showConfirmationDialog(
      context: context,
      type: DialogType.delete,
      title: "Confirm deletion",
      content: Text("Are you sure you want to delete ${item.text} ?"),
      cancelButtonCallback: () {
        Navigator.pop(context);
      },
      continueButtonCallback: () {
        controller.deleteItem(
            controller.shoppingListMenuController.selectedShoppingList.uid,
            item);
        Navigator.pop(context);
      },
    );
  }
}
