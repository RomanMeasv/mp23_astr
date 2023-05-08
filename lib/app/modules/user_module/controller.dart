import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/shopping_list_module/page.dart';
import 'package:mp23_astr/app/modules/user_module/auth_repository.dart';
import 'package:mp23_astr/app/modules/user_module/binding.dart';
import 'package:mp23_astr/app/modules/user_module/page.dart';
import 'package:mp23_astr/app/modules/user_module/repository.dart';

import '../../data/model/user.dart';
import '../shopping_list_module/binding.dart';

class UserController extends GetxController {
  final UserRepository repository;
  final AuthRepository authRepository;

  UserController(this.repository, this.authRepository) {
    authRepository.authStateChanges.listen((user) {
      syncAppWithAuthState(user);
    }
    );
  }

  final UserModel rxUserModel = UserModel();
  get user => rxUserModel;

  syncAppWithAuthState(user) async {
    if (user != null) {
      print("Syncing rxUserModel");
      // Fetch the UserModel from the UserRepository
      UserModel userModel = await repository.getUser(user.uid);

      // Update the rxUserModel
      rxUserModel.uid = userModel.uid;
      rxUserModel.email = userModel.email;
      rxUserModel.shoppingListIds = userModel.shoppingListIds;

      //Navigate to the ShoppingListPage, if the user is logged in
      Get.offAll(() => ShoppingListPage(), binding: ShoppingListBinding());
    }
    else {
      // Reset the rxUserModel
      print("Resetting rxUserModel");
      rxUserModel.reset();

      // Navigate to the UserPage, if the user is logged out
      Get.offAll(() => UserPage(), binding: UserBinding());
    }
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
}
