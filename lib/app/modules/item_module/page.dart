import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/carousel_module/widgets/carousel_card.dart';

import 'controller.dart';

class ItemPage extends GetView<ItemController> {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        allowImplicitScrolling: true,
        controller: controller.verticalController,
        scrollDirection: Axis.vertical,
        children: [
          _buildPhotoPart(),
          _buildCarousel(),
          //_buildPhotoRemover(),
        ],
      ),
    );
  }

  Widget _buildPhotoPart() {
    return Obx(
      () => controller.capturedImage.value == null
          ? _buildPhotoTaker()
          : _buildPhotoEditor(),
    );
  }

  Widget _buildCarousel() {
    return controller.obx(
      (items) => PageView.builder(
        allowImplicitScrolling: true,
        controller: controller.horizontalController,
        itemCount: items!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // print('ITEMS: $items');
          return CarouselCard(item: items[index]);
        },
      ),
    );

    // return PageView.builder(
    //   allowImplicitScrolling: true,
    //   controller: controller.horizontalController,
    //   itemCount: controller.itemCount,
    //   scrollDirection: Axis.horizontal,
    //   itemBuilder: (context, index) {
    //     return Obx(() => CarouselCard(item: controller.itemAtIndex(index)));
    //   },
    // );
  }

  Widget _buildPhotoTaker() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Obx(
          () => controller.isCameraReady.value
              ? SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: CameraPreview(controller.cameraController),
                )
              : const Center(child: CircularProgressIndicator()),
        ),
        ElevatedButton(
          onPressed: () => controller.captureImage(),
          child: const Icon(Icons.camera_alt_outlined),
        ),
      ],
    );
  }

  Widget _buildPhotoEditor() {
    return Obx(
      () => Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(
              File(controller.capturedImage.value!.path),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextField(
              //autofocus: true,
              scrollPhysics: const NeverScrollableScrollPhysics(),
              controller: controller.textFieldController,
              decoration: const InputDecoration(
                hintText: "Type...",
                border: InputBorder.none,
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton.icon(
              onPressed: () {
                controller.saveItem();
              },
              icon: const Icon(Icons.save_rounded),
              label: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
