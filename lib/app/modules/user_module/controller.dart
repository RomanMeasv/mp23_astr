import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/user_module/auth_repository.dart';
import 'package:mp23_astr/app/modules/user_module/repository.dart';

import '../../data/model/user.dart';

class UserController extends GetxController {
  final UserRepository repository;
  final AuthRepository authRepository;
  UserController(this.repository, this.authRepository) {
    authRepository.authStateChanges.listen((user) {
      // Check if firebaseUser is not null
      if (user != null) {
        rxUserModel.update(UserModel(uid: user.uid, email: user.email));
        print("User's email set to: ${user.email}");
        // Fetch the UserModel from the UserRepository
        //UserModel userModel = await repository.getUser(firebaseUser.uid);

        // Update the rxUserModel with the fetched UserModel
        //rxUserModel = RxUserModel(userModel);
      } else {
        rxUserModel.reset();
      }
    });
  }

  final RxUserModel rxUserModel = RxUserModel();
  get user => rxUserModel;

  void signUp(String email, String password) async {
    await authRepository.signUp(email, password);
  }
}
