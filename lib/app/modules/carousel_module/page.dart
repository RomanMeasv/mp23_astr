import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/carousel_module/controller.dart';
import 'package:mp23_astr/app/modules/carousel_module/widgets/carousel_card.dart';

class CarouselPage extends GetView<CarouselController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: PageView(
          allowImplicitScrolling: true,
          controller: controller.horizontalController,
          scrollDirection: Axis.horizontal,
          children: _buildCarousel(),
        ),
      ),
    );
  }

  List<Widget> _buildCarousel() {
    return controller
        .getAllItems()
        .value
        // don't show image-less item's
        .where((element) => element.imageUrl != null)
        .map((item) => CarouselCard(item: item))
        .toList();
  }
}
