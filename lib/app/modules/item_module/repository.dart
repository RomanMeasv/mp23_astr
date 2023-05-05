import 'package:mp23_astr/app/data/model/item.dart';

import '../../data/provider/item_provider.dart';

class ItemRepository {
  final ItemProvider api;

  ItemRepository(this.api);

  getAll() async {
    List<ItemModel> allItems = await api.getAll("OfwoYr2jeCBDrp4FRAVc");
    return allItems;
  }

  addItem(text, image) async {
    String? imageUrl = await api.uploadImage(image);
    if (imageUrl == null) throw Exception("Image not uploaded");

    ItemModel item = ItemModel(text: text, imageUrl: imageUrl);
    ItemModel createdItem = await api.addItem("OfwoYr2jeCBDrp4FRAVc", item);
  }

  getById(id) {
    return api.getById("OfwoYr2jeCBDrp4FRAVc", id);
  }

  delete(id) {
    return api.delete(id);
  }

  edit(obj) {
    return api.edit(obj);
  }
}
