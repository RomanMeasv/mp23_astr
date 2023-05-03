import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_connect/connect.dart';
import 'package:mp23_astr/app/data/model/item.dart';

class ItemProvider extends GetConnect {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> getAll() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('/ShoppingList/OfwoYr2jeCBDrp4FRAVc/Item')
          .get();

      var list = snapshot.docs.map((doc) {
        print(doc.data());
        return doc.data();
      }).toList();
    } catch (e) {
      print(e);
    }
  }

  getId(id) {}

  edit(obj) {}

  add(obj) {}

//   // Get request
//   Future<Response> getUser(int id) => get('http://youapi/users/id');
// // Post request
//   Future<Response> postUser(Map data) => post('http://youapi/users', data);
// // Post request with File
//   Future<Response<ItemModel>> postCases(List<int> image) {
//     final form = FormData({
//       'file': MultipartFile(image, filename: 'avatar.png'),
//       'otherFile': MultipartFile(image, filename: 'cover.png'),
//     });
//     return post('http://youapi/users/upload', form);
//   }

//   GetSocket userMessages() {
//     return socket('https://yourapi/users/socket');
//   }
}
