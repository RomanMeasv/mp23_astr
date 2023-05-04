import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/user_module/auth_repository.dart';
import 'package:mp23_astr/app/modules/user_module/repository.dart';

import '../../data/model/user.dart';

class UserController extends GetxController {
  final UserRepository repository;
  final AuthRepository authRepository;

  UserController(this.repository, this.authRepository) {
    authRepository.authStateChanges.listen((user) {
      syncUserModel(user);
    }
    );
  }

  final UserModel rxUserModel = UserModel();
  get user => rxUserModel;

  syncUserModel(user) async {
    if (user != null) {
      print("Syncing rxUserModel");
      // Fetch the UserModel from the UserRepository
      UserModel userModel = await repository.getUser(user.uid);

      // Update the rxUserModel
      rxUserModel.uid = userModel.uid;
      rxUserModel.email = userModel.email;
      rxUserModel.shoppingListIds = userModel.shoppingListIds;
    }
    else {
      // Reset the rxUserModel
      print("Resetting rxUserModel");
      rxUserModel.reset();
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
