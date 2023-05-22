import 'package:camera/camera.dart';
import 'package:mp23_astr/app/data/model/item.dart';
import 'package:mp23_astr/app/data/provider/camera_image_provider.dart';

class CameraRepository {
  final CameraImageProvider api;

  CameraRepository(this.api);

  Future<String?> addImage(
      String shoppingListId, ItemModel item, XFile image) async {
    // upload image to firestorage, this gets us a url of the image
    String? imageUrl = await api.uploadImage(image);
    if (imageUrl == null) throw Exception("Image not uploaded");

    // add image url to image
    await api.addImageUrlToItem(shoppingListId, item, imageUrl);

    return imageUrl;
  }

// getAll(){
//   return api.getAll();
// }
// getId(id){
//   return api.getId(id);
// }
// delete(id){
//   return api.delete(id);
// }
// edit(obj){
//   return api.edit( obj );
// }
// add(obj){
//     return api.add( obj );
// }
}
