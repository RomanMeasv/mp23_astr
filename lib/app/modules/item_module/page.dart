import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/item_module/widgets/carousel_card.dart';

import 'controller.dart';
import 'widgets/photo_remover.dart';
import 'widgets/photo_taker.dart';

class ItemPage extends GetView<ItemController> {
  ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        allowImplicitScrolling: true,
        controller: controller.verticalController,
        scrollDirection: Axis.vertical,
        children: [
          _buildPhotoPart(context),
          _buildCarousel(),
          //_buildPhotoRemover(),
        ],
      ),
    );
  }

  Widget _buildPhotoPart(context) {
    return Obx(
      () => controller.capturedImage.value == null
          ? _buildPhotoTaker(context)
          : _buildPhotoEditor(context),
    );
  }

  Widget _buildCarousel() {
    return PageView.builder(
      allowImplicitScrolling: true,
      controller: controller.horizontalController,
      itemCount: controller.itemCount,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return CarouselCard(item: controller.item(index));
      },
    );
  }

  Widget _buildPhotoTaker(context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Obx(
          () => controller.isCameraReady.value
              ? CameraPreview(controller.cameraController)
              : const CircularProgressIndicator(),
        ),
        ElevatedButton(
          onPressed: () => controller.captureImage(),
          child: const Icon(Icons.camera_alt_outlined),
        ),
      ],
    );
  }

  Widget _buildPhotoEditor(context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Enter text",
                  border: InputBorder.none,
                ),
                onSubmitted: (String value) {
                  controller.text = value;
                  Get.back();
                },
              ),
            );
          },
        );
      },
      child: Stack(
        children: [
          Obx(
            () => Image.file(
              File(controller.capturedImage.value!.path),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Obx(
              () => Text(controller.text.value),
            ),
          ),
        ],
      ),
    );
  }
}
