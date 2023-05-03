import 'package:get/get.dart';

class RxUserModel {
  final uid = ''.obs;
  final email = ''.obs;
}

class UserModel {
  UserModel({uid, email});

  final rx = RxUserModel();

  get uid => rx.uid.value;
  set uid(value) => rx.uid.value = value;

  get email => rx.email.value;
  set email(value) => rx.email.value = value;

  UserModel.fromJson(Map<String, dynamic> json) {
    this.uid = json['uid'];
    this.email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['email'] = this.email;
    return data;
  }
}