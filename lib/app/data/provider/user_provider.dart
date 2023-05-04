import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_connect/connect.dart';
import 'package:mp23_astr/app/data/model/user.dart';

class UserProvider extends GetConnect {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserModel> getUser(String uid) {
    //TODO: Add try/catch
    return firestore.collection('users').doc(uid).get().then((value) {
      return UserModel.fromJson(value.data()!);
    });
  }
}