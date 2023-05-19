import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/camera_module/controller.dart';

class CameraPage extends GetView<CameraPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CameraPage')),
      body: SafeArea(
        child: Stack(
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
        ),
      ),
    );
  }
}
