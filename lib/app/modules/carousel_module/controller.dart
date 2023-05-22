import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/data/model/item.dart';

class CarouselController extends GetxController {
  final args = Get.arguments;

  late PageController _horizontalController;
  PageController get horizontalController => _horizontalController;

  Rx<List<ItemModel>> getAllItems() => args["Items"];

  @override
  void onInit() {
    _horizontalController = PageController();
    super.onInit();
  }

  CarouselController();
}
