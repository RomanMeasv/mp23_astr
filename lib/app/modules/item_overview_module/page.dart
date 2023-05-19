import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/item_overview_module/controller.dart';
import 'package:mp23_astr/app/modules/shopping_list_menu_module/controller.dart';
import 'package:mp23_astr/app/modules/user_module/controller.dart';

import '../../data/model/item.dart';

class ItemOverviewPage extends GetView<ItemOverviewController> {
  ShoppingListMenuController shoppingListMenuController =
      Get.find<ShoppingListMenuController>();
  UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return showBottomSheet(
                    context, false, ItemModel(text: "", imageUrl: ""));
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Item Overview'),
          centerTitle: true,
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: controller.rxItemList.value.length,
            itemBuilder: (context, int index) {
              return ListTile(
                title: Text(controller.rxItemList.value[index].text),
                onTap: () {
                  print(
                      "Value of bought: ${controller.rxItemList.value[index].bought}");
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                      ),
                      onPressed: () {},
                    ),
                    Visibility(
                      visible:
                          controller.rxItemList.value[index].bought == false,
                      child: IconButton(
                        icon: const Icon(
                          Icons.check_box_outline_blank_rounded,
                        ),
                        onPressed: () {
                          controller.buyItem(
                              shoppingListMenuController
                                  .selectedShoppingList.uid,
                              controller.rxItemList.value[index]);
                        },
                      ),
                    ),
                    Visibility(
                      visible:
                          controller.rxItemList.value[index].bought == true,
                      child: IconButton(
                        icon: const Icon(
                          Icons.check_box_outlined,
                        ),
                        onPressed: () {
                          controller.buyItem(
                              shoppingListMenuController
                                  .selectedShoppingList.uid,
                              controller.rxItemList.value[index]);
                        },
                      ),
                    ),
                    IconButton(
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

                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                      ),
                      onPressed: () {
                        showDeleteAlertDialog(
                            context, controller.rxItemList.value[index]);
                      },
                    ),

                    // Visibility(
                    //   visible: controller.rxShoppingLists.value[index].owner !=
                    //       userController.rxUserModel.uid,
                    //   child: IconButton(
                    //     icon: const Icon(
                    //       Icons.directions_run_rounded,
                    //     ),
                    //     onPressed: () {
                    //       // controller.deleteShoppingList(
                    //       //     controller.rxShoppingLists.value[index]);
                    //       showLeaveListAlertDialog(
                    //           context, controller.rxShoppingLists.value[index]);
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          ),
        ));
  }

  String? value;
  Widget showBottomSheet(BuildContext context, bool isUpdate, ItemModel item) {
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
                // Update Shopping List.
                label: Text(isUpdate ? item.text : 'Enter an Item'),
                // labelText:
                //     isUpdate ? 'Update Shopping List' : 'Add Shopping List',
                hintText: 'Enter an Item',
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
                  item.text = value!;
                  controller.updateItem(
                      controller
                          .shoppingListMenuController.selectedShoppingList.uid,
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
                      'UPDATE Item',
                      style: TextStyle(color: Colors.white),
                    )
                  : const Text('ADD Item',
                      style: TextStyle(color: Colors.white))),
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
    Widget cancelButton = TextButton(
      onPressed: cancelButtonCallback,
      child: const Text("Cancel"),
    );
    Widget continueButton = TextButton(
      onPressed: continueButtonCallback,
      child: Text(
          type == DialogType.User ? "Add Shopping List to User" : "Continue"),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        cancelButton,
        continueButton,
      ],
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
      type: DialogType.Delete,
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

typedef ButtonCallback = void Function();

enum DialogType {
  Delete,
  Leave,
  User,
}