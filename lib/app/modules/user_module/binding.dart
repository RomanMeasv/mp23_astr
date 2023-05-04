import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/user_module/auth_repository.dart';
import 'package:mp23_astr/app/modules/user_module/repository.dart';

import '../../data/provider/auth_provider.dart';
import '../../data/provider/user_provider.dart';
import 'controller.dart';

class UserBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<UserController>(() => UserController(
     UserRepository(UserProvider()), AuthRepository(AuthProvider())));
  }
}