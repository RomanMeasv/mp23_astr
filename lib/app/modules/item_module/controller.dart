import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/item_module/repository.dart';

class ItemController extends GetxController {

final ItemRepository repository;
ItemController(this.repository);

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}