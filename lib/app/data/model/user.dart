import 'package:get/get.dart';

class RxUserModel {
  final uid = ''.obs;
  final email = ''.obs;
  final shoppingListIds = <String>[].obs;
}

class UserModel {
  UserModel({uid, email});

  final rx = RxUserModel();

  get uid => rx.uid.value;
  set uid(value) => rx.uid.value = value;

  get email => rx.email.value;
  set email(value) => rx.email.value = value;

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = uid;
    data['email'] = email;
    return data;
  }

  reset() {
    uid = "";
    email = "";
  }
}