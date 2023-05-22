import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/carousel_module/controller.dart';

class CarouselPage extends GetView<CarouselController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CarouselPage')),
      body: SafeArea(child: Text('CarouselController')),
    );
  }
}
