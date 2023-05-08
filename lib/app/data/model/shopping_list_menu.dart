import 'package:get/get.dart';

class RxShoppingListMenuModel {
  final date = '0'.obs;
  final name = 'name'.obs;
}

class ShoppingListMenuModel {
  ShoppingListMenuModel({name, date}) {
    rx.name.value = name;
    rx.date.value = date;
  }

  final rx = RxShoppingListMenuModel();

  get name => rx.name.value;
  set name(value) => rx.name.value = value;

  get date => rx.date.value;
  set date(value) => rx.date.value = value;

  ShoppingListMenuModel.fromJson(Map<String, dynamic> json) {
    print("JSON:");
    print(json);

    this.date = json['date'];
    this.name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['date'] = this.date;
    return data;
  }
}
