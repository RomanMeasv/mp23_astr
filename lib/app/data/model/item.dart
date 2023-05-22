import 'package:camera/camera.dart';

class ItemModel {
  late String id;
  String text = "";
  String? imageUrl;
  XFile? image;
  bool bought = false;

  ItemModel({required this.text});

  ItemModel.fromJson(String itemId, Map<String, dynamic> json) {
    id = itemId;
    text = json['text'];
    imageUrl = json['imageUrl'];
    // image = json['imageUrl'];
    bought = json['bought'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> item = <String, dynamic>{
      'text': text,
      'imageUrl': imageUrl,
      'bought': bought
    };
    return item;
  }

  @override
  String toString() {
    return 'ID: $id, text: $text, imageUrl: $imageUrl, image: $image, bought: $bought';
  }
}
