import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/shopping_list_module/repository.dart';

class ShoppingListMenuController extends GetxController {

final ShoppingListRepository repository;
ShoppingListMenuController(this.repository);

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}