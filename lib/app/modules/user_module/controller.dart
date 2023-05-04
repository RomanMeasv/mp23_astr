import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/user_module/auth_repository.dart';
import 'package:mp23_astr/app/modules/user_module/repository.dart';

import '../../data/model/user.dart';

class UserController extends GetxController {
  final UserRepository repository;
  final AuthRepository authRepository;

  UserController(this.repository, this.authRepository) {
    authRepository.authStateChanges.listen((user) {
      print("User: $user");
      if (user != null) {
        print("Updating rxUserModel");
        //I couldn't make an update() method ffs :)
        rxUserModel.uid = user.uid;
        rxUserModel.email = user.email;

        // Fetch the UserModel from the UserRepository
        //UserModel userModel = await repository.getUser(firebaseUser.uid);

        // Update the rxUserModel with the fetched UserModel
        //rxUserModel = RxUserModel(userModel);
      }
      else {
        // Reset the rxUserModel
        print("Resetting rxUserModel");
        rxUserModel.reset();
      }
    }
    );
  }

  final UserModel rxUserModel = UserModel();
  get user => rxUserModel;

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
