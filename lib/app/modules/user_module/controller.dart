import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/user_module/repository.dart';

class UserController extends GetxController {

final UserRepository repository;
UserController(this.repository);

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}