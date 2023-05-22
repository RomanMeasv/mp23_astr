import 'package:camera/camera.dart';

class ItemModel {
  String? id;
  late String text;
  late String imageUrl;
  XFile? image;
  bool? bought;

  ItemModel({this.id, required this.text, required this.imageUrl});

  ItemModel.fromJson(String itemId, Map<String, dynamic> json) {
    id = itemId;
    text = json['text'];
    imageUrl = json['imageUrl'];
    bought = json['bought'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> item = <String, dynamic>{
      'id': id,
      'text': text,
      'imageUrl': imageUrl,
      'image': image,
      'bought': bought
    };
    return item;
  }

  @override
  String toString() {
    return 'ID: $id, text: $text, imageUrl: $imageUrl, image: $image, bought: $bought';
  }
}
