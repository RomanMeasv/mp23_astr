import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/data/model/user.dart';
import 'package:mp23_astr/app/modules/item_module/binding.dart';
import 'package:mp23_astr/app/modules/user_module/controller.dart';

import '../../data/model/shopping_list_menu.dart';
import '../item_module/page.dart';
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
                Get.to(() => ItemPage(), binding: ItemBinding());
              },
              child: Container(
                margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onBackground,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 10, top: 5),
                        alignment: Alignment.centerLeft,
                        child:
                            Text(controller.rxShoppingLists.value[index].name)),
                    Container(
                        margin: const EdgeInsets.only(left: 10, top: 5),
                        alignment: Alignment.centerLeft,
                        child: const Text("Member 1, Member 2" //Styling
                            // controller.rxShoppingLists.value[index].members.toString()
                            )),
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
                                      borderRadius: BorderRadius.circular(8.0),
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
                                      borderRadius: BorderRadius.circular(8.0),
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
                              SizedBox(
                                width: buttonSize.width + 70,
                                height: buttonSize.height,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Invite'),
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

            // return ListTile(
            //   title: Text(controller.rxShoppingLists.value[index].name),
            //   onTap: () {
            //     controller.selectedShoppingList =
            //         controller.rxShoppingLists.value[index];
            //     Get.to(() => ItemPage(), binding: ItemBinding());
            //   },
            //   trailing: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       IconButton(
            //         icon: const Icon(
            //           Icons.contact_mail,
            //         ),
            //         onPressed: () {
            //           // controller.deleteShoppingList(
            //           //     controller.rxShoppingLists.value[index]);
            //           showUserAlertDialog(
            //               context, controller.rxShoppingLists.value[index]);
            //         },
            //       ),
            //       IconButton(
            //         icon: const Icon(
            //           Icons.edit,
            //         ),
            //         onPressed: () {
            //           showModalBottomSheet(
            //             context: context,
            //             builder: (context) {
            //               return showBottomSheet(context, true,
            //                   controller.rxShoppingLists.value[index]);
            //             },
            //           );
            //         },
            //       ),
            //       Visibility(
            //         visible: controller.rxShoppingLists.value[index].owner ==
            //             userController.rxUserModel.uid,
            //         child: IconButton(
            //           icon: const Icon(
            //             Icons.delete_outline,
            //           ),
            //           onPressed: () {
            //             // controller.deleteShoppingList(
            //             //     controller.rxShoppingLists.value[index]);
            //             showAlertDialog(
            //                 context, controller.rxShoppingLists.value[index]);
            //           },
            //         ),
            //       ),
            //       Visibility(
            //         visible: controller.rxShoppingLists.value[index].owner !=
            //             userController.rxUserModel.uid,
            //         child: IconButton(
            //           icon: const Icon(
            //             Icons.directions_run_rounded,
            //           ),
            //           onPressed: () {
            //             // controller.deleteShoppingList(
            //             //     controller.rxShoppingLists.value[index]);
            //             showLeaveListAlertDialog(
            //                 context, controller.rxShoppingLists.value[index]);
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // );
          },
        ),
      ),
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
    );
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
                // Update Shopping List.
                label: Text(isUpdate
                    ? shoppingList.name
                    : 'Enter a Shopping List name'),
                // labelText:
                //     isUpdate ? 'Update Shopping List' : 'Add Shopping List',
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

  showAlertDialog(BuildContext context, ShoppingListMenuModel shoppingList) {
    showConfirmationDialog(
      context: context,
      type: DialogType.Delete,
      title: "Confirm deletion",
      content: Text("Are you sure you want to delete ${shoppingList.name} ?"),
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
      content: Column(
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
