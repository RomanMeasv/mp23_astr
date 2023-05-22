import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/data/model/item.dart';
import 'package:mp23_astr/app/modules/item_module/repository.dart';
import 'package:mp23_astr/app/modules/item_overview_module/repository.dart';
import 'package:mp23_astr/app/modules/shopping_list_menu_module/controller.dart';

class ItemOverviewController extends GetxController {
  ShoppingListMenuController shoppingListMenuController =
      Get.find<ShoppingListMenuController>();
  ItemOverviewController(this.repository);

  Rx<List<ItemModel>> rxItemList = Rx<List<ItemModel>>([]);

  final ItemOverviewRepository repository;

  get shoppingListId => shoppingListMenuController.selectedShoppingList.uid;

  ItemModel itemByIndex(index) {
    return rxItemList.value[index];
  }

  String? itemId(index) {
    return itemByIndex(index).id;
  }

  @override
  void onInit() async {
    getAll();
    super.onInit();
  }

  addItem(String shoppingList, String itemName) async {
    ItemModel itemAdded = ItemModel(text: "", imageUrl: '');
    itemAdded.bought == false;
    itemAdded = await repository.addItem(shoppingList, itemName);
    rxItemList.value.add(itemAdded);
    shoppingListMenuController.getAll();
    getAll();
    print("RXITEMS LIST LENGTH ${rxItemList.value.length}");
  }

  getAll() async {
    print("IN GETALL CONTROLLER");
    rxItemList.value.clear();
    List<ItemModel> itemList = await repository
        .getAll(shoppingListMenuController.selectedShoppingList.uid);
    rxItemList.value = List.from(itemList);
  }

  deleteItem(String shoppingListId, ItemModel item) {
    repository.deleteItem(shoppingListId, item);
    shoppingListMenuController.getAll();
    getAll();
  }

  void updateItem(String shoppingListId, ItemModel item) {
    repository.updateItem(shoppingListId, item);
    getAll();
  }

  void buyItem(String shoppingListId, ItemModel item) {
    item.bought = !item.bought!;
    repository.updateItem(shoppingListId, item);
    getAll();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
