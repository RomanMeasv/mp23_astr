import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/user_module/auth_repository.dart';
import 'package:mp23_astr/app/modules/user_module/binding.dart';
import 'package:mp23_astr/app/modules/user_module/page.dart';
import 'package:mp23_astr/app/modules/user_module/repository.dart';

import '../../data/model/user.dart';
import '../shopping_list_menu_module/binding.dart';
import '../shopping_list_menu_module/page.dart';

class UserController extends GetxController {
  final UserRepository repository;
  final AuthRepository authRepository;

  UserController(this.repository, this.authRepository) {
    authRepository.authStateChanges.listen((user) {
      _syncAppWithAuthState(user);
    });
  }

  final UserModel rxUserModel = UserModel();
  get user => rxUserModel;

  _syncAppWithAuthState(user) async {
    print("AuthState: $user");
    if (user != null) {
      print("Syncing rxUserModel");
      // Fetch the UserModel from the UserRepository
      UserModel userModel = await _fetchUser(user);

      if (userModel.uid == "") {
        return;
      }

      // Update the rxUserModel
      rxUserModel.uid = userModel.uid;
      rxUserModel.email = userModel.email;
      rxUserModel.shoppingListIds = userModel.shoppingListIds;

      //Navigate to the ShoppingListPage, if the user is logged in
      Get.offAll(() => ShoppingListMenuPage(),
          binding: ShoppingListMenuBinding());
    } else {
      // Reset the rxUserModel
      print("Resetting rxUserModel");
      rxUserModel.reset();

      // Navigate to the UserPage, if the user is logged out
      Get.offAll(() => UserPage(), binding: UserBinding());
    }
  }

  Future<UserModel> _fetchUser(user) async {
    UserModel userModel = UserModel();
    num attempts = 0;
    print("Fetching user with UID: ${user.uid}");
    do {
      try {
        userModel = await repository.getUser(user.uid);
      } catch (e) {
        print(
            "Error: $e -> Waiting for Cloud Function to execute. Try: ${++attempts}");
        await Future.delayed(Duration(seconds: 1));
      }
    } while (userModel.uid == "" && attempts < 10);
    if (attempts > 10) {
      print("Could not fetch user.");
    }
    return userModel;
  }

  void signUp(String email, String password) async {
    await authRepository.signUp(email, password);
    //Navigate to the ShoppingListPage, if the user is logged in
  }

  void signIn(String email, String password) async {
    await authRepository.signIn(email, password);
    //Navigate to the ShoppingListPage, if the user is logged in
  }

  // Methods below are not used in the page respective to this module but are used in other modules

  void signOut() async {
    await authRepository.signOut();
  }

  void signInWithGoogle() async {
    await authRepository.signInWithGoogle();
  }

  void assignShoppingList(String shoppingListId) async {
    await repository.assignShoppingList(user.uid, shoppingListId);
    rxUserModel.shoppingListIds.add(shoppingListId);
  }

  void deAssignShoppingList(String shoppingListId) async {
    await repository.deAssignShoppingList(user.uid, shoppingListId);
    rxUserModel.shoppingListIds.remove(shoppingListId);
  }
}
