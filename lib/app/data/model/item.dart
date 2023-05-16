import 'package:camera/camera.dart';

class ItemModel {
  String? id;

  late String text;

  late XFile image;
  late String imagePath;
  late String imageUrl;

  ItemModel(this.text, this.image);

  ItemModel.fromJson(String itemId, Map<String, dynamic> json) {
    id = itemId;
    text = json['text'];
    imageUrl = json['imageUrl'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> item = <String, dynamic>{
      'id': id,
      'text': text,
      'imageUrl': imageUrl,
      'imagePath': imagePath,
    };
    return item;
  }

  @override
  String toString() {
    return 'ID: $id, text: $text, imagePath: $imagePath, imageUrl: $imageUrl';
  }
}
