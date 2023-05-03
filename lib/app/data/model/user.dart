import 'package:get/get.dart';

class RxUserModel {
  final uid = ''.obs;
  final email = ''.obs;

  void update(UserModel userModel) {
    uid.value = userModel.uid;
    email.value = userModel.email;
  }

  void reset() {
    uid.value = '';
    email.value = '';
  }
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