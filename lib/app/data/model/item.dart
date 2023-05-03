import 'package:get/get.dart';

class RxItemModel {
  final id = 1.obs;
  final text = 'some text'.obs;
  final imageUrl =
      'https://www.eatthis.com/wp-content/uploads/sites/4/2022/09/cereal-aisle.jpg?quality=82&strip=1&w=640'
          .obs;
}

class ItemModel {
  ItemModel({id, text, imageUrl});

  final rx = RxItemModel();

  get text => rx.text.value;
  set text(value) => rx.text.value = value;

  get id => rx.id.value;
  set id(value) => rx.id.value = value;

  get imageUrl => rx.imageUrl.value;
  set imageUrl(value) => rx.imageUrl.value = value;

  ItemModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.text = json['text'];
    this.imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
