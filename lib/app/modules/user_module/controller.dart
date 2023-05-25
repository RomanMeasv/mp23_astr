import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/user_module/auth_repository.dart';
import 'package:mp23_astr/app/modules/user_module/binding.dart';
import 'package:mp23_astr/app/modules/user_module/page.dart';
import 'package:mp23_astr/app/modules/user_module/repository.dart';

import 'package:mp23_astr/app/data/model/user.dart';
import 'package:mp23_astr/app/modules/shopping_list_menu_module/binding.dart';
import 'package:mp23_astr/app/modules/shopping_list_menu_module/page.dart';

class UserController extends GetxController {
  final UserRepository repository;
  final AuthRepository authRepository;
  RxBool isLogging = false.obs;

  UserController(this.repository, this.authRepository) {
    authRepository.authStateChanges.listen((user) {
      _syncAppWithAuthState(user);
    });
  }

  final UserModel rxUserModel = UserModel();
  get user => rxUserModel;

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  _syncAppWithAuthState(user) async {
    if (user != null) {
      // Fetch the UserModel from the UserRepository
      UserModel? userModel = await _fetchUser(user);

      if (userModel == null) {
        return;
      }

      //Add the FCM token to the user
      String? token = await messaging.getToken();
      if (token != null) {
        await repository.addFcmToken(userModel.uid, token);
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
      rxUserModel.reset();

      // Navigate to the UserPage, if the user is logged out
      Get.offAll(() => UserPage(), binding: UserBinding());
    }
  }

  Future<UserModel?> _fetchUser(user) async {
    UserModel userModel = UserModel();
    num attempts = 0;
    bool userFetched = false; // Flag variable to indicate if a valid user is fetched

    do {
      try {
        userModel = await repository.getUser(user.uid);
      } catch (e) {
        await Future.delayed(const Duration(seconds: 1));
      }

      // Check if a valid user is fetched
      if (userModel.uid != "") {
        userFetched = true;
      }
    } while (!userFetched && attempts < 20);

    if (!userFetched) {
      return null;
    }

    return userModel;
  }

  void signUp(String email, String password) async {
    await authRepository.signUp(email, password);
  }

  void signIn(String email, String password) async {
    await authRepository.signIn(email, password);
  }

  void signOut() async {
    await authRepository.signOut();
  }

  void signInWithGoogle() async {
    await authRepository.signInWithGoogle();
  }

  void changeToRegisterWidget() {
    isLogging(false);
  }



  // Methods below are not used in the page respective to this module but are used in other modules

  void assignShoppingList(String shoppingListId) async {
    await repository.assignShoppingList(user.uid, shoppingListId);
    rxUserModel.shoppingListIds.add(shoppingListId);
  }

  void deAssignShoppingList(String shoppingListId) async {
    await repository.deAssignShoppingList(user.uid, shoppingListId);
    rxUserModel.shoppingListIds.remove(shoppingListId);
  }
}
