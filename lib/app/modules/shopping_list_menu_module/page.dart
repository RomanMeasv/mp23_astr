import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/data/model/user.dart';
import 'package:mp23_astr/app/modules/item_module/binding.dart';
import 'package:mp23_astr/app/modules/user_module/controller.dart';

import '../../data/model/shopping_list_menu.dart';
import '../item_module/page.dart';
import '../item_overview_module/binding.dart';
import '../item_overview_module/page.dart';
import '../shopping_list_menu_module/controller.dart';

typedef ButtonCallback = void Function();

enum DialogType {
  Delete,
  Leave,
  User,
}

class ShoppingListMenuPage extends GetView<ShoppingListMenuController> {
  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Shopping lists',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Logout',
                onPressed: () {
                  controller.signOut();
                }),
          ]),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.rxShoppingLists.value.length,
          itemBuilder: (context, int index) {
            return GestureDetector(
              onTap: () {
                controller.selectedShoppingList =
                    controller.rxShoppingLists.value[index];
                Get.to(() => ItemOverviewPage(),
                    binding: ItemOverviewBinding());
              },
              child: Container(
                margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onBackground,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 10, top: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                            controller.rxShoppingLists.value[index].name,
                            style: Theme.of(context).textTheme.bodyLarge)),
                    Container(
                        margin: const EdgeInsets.only(left: 10, top: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Item count: ${controller.rxShoppingLists.value[index].itemCount}")),
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 10),
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      height: 50,
                      width: double.maxFinite,
                      alignment: Alignment.centerLeft,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final buttonSize = Size(
                            constraints.maxWidth / 4,
                            constraints.maxHeight - 5,
                          );
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible: controller
                                        .rxShoppingLists.value[index].owner ==
                                    userController.rxUserModel.uid,
                                child: SizedBox(
                                  width: buttonSize.width,
                                  height: buttonSize.height,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return showBottomSheet(
                                              context,
                                              true,
                                              controller
                                                  .rxShoppingLists.value[index],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller
                                        .rxShoppingLists.value[index].owner ==
                                    userController.rxUserModel.uid,
                                child: SizedBox(
                                  width: buttonSize.width,
                                  height: buttonSize.height,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        showDeleteAlertDialog(
                                            context,
                                            controller
                                                .rxShoppingLists.value[index]);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller
                                        .rxShoppingLists.value[index].owner !=
                                    userController.rxUserModel.uid,
                                child: SizedBox(
                                  width: buttonSize.width,
                                  height: buttonSize.height,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.directions_run_rounded,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        showLeaveListAlertDialog(
                                            context,
                                            controller
                                                .rxShoppingLists.value[index]);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                child: SizedBox(
                                  width:
                                      buttonSize.width + buttonSize.width / 1.2,
                                  height: buttonSize.height,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showUserAlertDialog(
                                          context,
                                          controller
                                              .rxShoppingLists.value[index]);
                                    },
                                    child: Text('Invite'),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return showBottomSheet(context, false, ShoppingListMenuModel());
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context)
                .colorScheme
                .secondary, // Set the desired button color here
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  // return ListTile(
  //   title: Text(controller.rxShoppingLists.value[index].name),
  //   onTap: () {
  //     controller.selectedShoppingList =
  //         controller.rxShoppingLists.value[index];
  //     Get.to(() => ItemPage(), binding: ItemBinding());
  //   },
  // trailing: Row(
  //   mainAxisSize: MainAxisSize.min,
  //   children: [
  //     IconButton(
  //       icon: const Icon(
  //         Icons.contact_mail,
  //       ),
  //       onPressed: () {
  //         // controller.deleteShoppingList(
  //         //     controller.rxShoppingLists.value[index]);
  //         showUserAlertDialog(
  //             context, controller.rxShoppingLists.value[index]);
  //       },
  //     ),
  //     IconButton(
  //       icon: const Icon(
  //         Icons.edit,
  //       ),
  //       onPressed: () {
  //         showModalBottomSheet(
  //           context: context,
  //           builder: (context) {
  //             return showBottomSheet(context, true,
  //                 controller.rxShoppingLists.value[index]);
  //           },
  //         );
  //       },
  //     ),
  //     Visibility(
  //       visible: controller.rxShoppingLists.value[index].owner ==
  //           userController.rxUserModel.uid,
  //       child: IconButton(
  //         icon: const Icon(
  //           Icons.delete_outline,
  //         ),
  //         onPressed: () {
  //           // controller.deleteShoppingList(
  //           //     controller.rxShoppingLists.value[index]);
  //           showAlertDialog(
  //               context, controller.rxShoppingLists.value[index]);
  //         },
  //       ),
  //     ),
  //     Visibility(
  //       visible: controller.rxShoppingLists.value[index].owner !=
  //           userController.rxUserModel.uid,
  //       child: IconButton(
  //         icon: const Icon(
  //           Icons.directions_run_rounded,
  //         ),
  //         onPressed: () {
  //           // controller.deleteShoppingList(
  //           //     controller.rxShoppingLists.value[index]);
  //           showLeaveListAlertDialog(
  //               context, controller.rxShoppingLists.value[index]);
  //         },
  //       ),
  //     ),
  //   ],
  // ),
  // );

  String? value;

  Widget showBottomSheet(
      BuildContext context, bool isUpdate, ShoppingListMenuModel shoppingList) {
    // Added the isUpdate argument to check if our item has been updated
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                isUpdate ? "Change Shopping list name" : "Shopping list name",
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
                    label: Text(isUpdate
                        ? shoppingList.name
                        : 'Enter a Shopping List name'),
                    hintText: 'New name for the shopping list',
                  ),
                  onChanged: (String _val) {
                    value = _val;
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
                      if (isUpdate) {
                        shoppingList.name = value;
                        controller.updateShoppingList(
                            shoppingList.uid, shoppingList);
                      } else {
                        if (value != null) {
                          controller.add(value!);
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
                            style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
      child: Text(type == DialogType.User ? "Add user" : "Continue"),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
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

  showDeleteAlertDialog(
      BuildContext context, ShoppingListMenuModel shoppingList) {
    showConfirmationDialog(
      context: context,
      type: DialogType.Delete,
      title: "Confirm deletion",
      content: Text(
        "Are you sure you want to delete ${shoppingList.name} ?",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      cancelButtonCallback: () {
        Navigator.pop(context);
      },
      continueButtonCallback: () {
        controller.deleteShoppingList(shoppingList);
        Navigator.pop(context);
      },
    );
  }

  showLeaveListAlertDialog(
      BuildContext context, ShoppingListMenuModel shoppingList) {
    showConfirmationDialog(
      context: context,
      type: DialogType.Leave,
      title: "Confirm leaving the list",
      content: Text("Are you sure you want to leave ${shoppingList.name} ?"),
      cancelButtonCallback: () {
        Navigator.pop(context);
      },
      continueButtonCallback: () {
        controller.deleteShoppingList(shoppingList);
        Navigator.pop(context);
      },
    );
  }

  showUserAlertDialog(
      BuildContext context, ShoppingListMenuModel shoppingList) {
    UserModel? selectedUser = UserModel();
    controller.getAllUsers();
    print("List User size : ${controller.listUsers.length}");

    showConfirmationDialog(
      context: context,
      type: DialogType.User,
      title: "Input a mail:",
      content: Container(
        width: Get.width * 0.9,
        height: Get.height * 0.3,
        child: Column(
          children: [
            Autocomplete<UserModel>(
              optionsBuilder: (TextEditingValue value) {
                // When the field is empty
                if (value.text.isEmpty) {
                  return [];
                }
                // The logic to find out which ones should appear
                return controller.listUsers.where((element) => element.email
                    .toLowerCase()
                    .contains(value.text.toLowerCase()));
              },
              onSelected: (value) {
                selectedUser = value;
                print("it works ${value.email} ID : ${value.uid}");
              },
              displayStringForOption: (option) => option.email,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(selectedUser!.email ?? 'Type something (a, b, c, etc)'),
          ],
        ),
      ),
      cancelButtonCallback: () {
        Navigator.pop(context);
      },
      continueButtonCallback: () {
        controller.addNewUserToShoppingList(selectedUser!.uid, shoppingList);
        Navigator.pop(context);
      },
    );
  }
}
