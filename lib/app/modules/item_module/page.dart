import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/item_module/widgets/carousel_card.dart';

import 'controller.dart';
import 'widgets/photo_remover.dart';
import 'widgets/photo_taker.dart';

class ItemPage extends GetView<ItemController> {
  final PageController _horizontalController = PageController();
  final PageController _verticalController =
      PageController(initialPage: 1); // start on carousel

  late CameraController _cameraController;
  late List<CameraDescription> _cameras;

  ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = List.from([
      _buildPhotoTaker(),
      _buildCarousel(),
      //_buildPhotoRemover(),
    ]);

    return Scaffold(
      body: PageView(
        allowImplicitScrolling: true,
        controller: _verticalController,
        scrollDirection: Axis.vertical,
        children: pages,
      ),
    );
  }

  Widget _buildPhotoTaker() {
    return Column(
      children: [
        Expanded(
          child: Obx(
            () => controller.isCameraReady.value
                ? CameraPreview(controller.cameraController)
                : Container(),
          ),
        ),
        ElevatedButton(
          onPressed: () => controller.captureImage(),
          child: Text('Capture Image'),
        ),
        SizedBox(height: 16),
        Obx(
          () => controller.capturedImage.value != null
              ? Image.file(
                  File(controller.capturedImage.value!.path),
                  height: 200,
                )
              : Container(),
        ),
      ],
    );
  }

  Widget _buildCarousel() {
    return PageView.builder(
      allowImplicitScrolling: true,
      controller: _horizontalController,
      itemCount: controller.itemCount,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return CarouselCard(item: controller.item(index));
      },
    );
  }

  Future<CameraDescription> _getCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    return cameras.first;
  }

  // FutureBuilder<CameraDescription> _buildCameraSelection() {
  //   return FutureBuilder(
  //     future: _getCamera(),
  //     builder: (context, snapshot) {
  //       return DropdownButton<CameraDescription>(
  //           value: camera?.value,
  //           hint: const Text('Select a camera'),
  //           items: snapshot.data
  //                   ?.map((e) => DropdownMenuItem(
  //                         value: e,
  //                         child: Text('${e.lensDirection.name} ${e.name}'),
  //                       ))
  //                   .toList() ??
  //               [],
  //           onChanged: (camera) {
  //             this.camera = Rx<CameraDescription>(camera!); //works
  //           });
  //     },
  //   );
  // }

  // Widget _buildCarousel() {
  //   return Consumer<EntryModel>(
  //     builder: (context, model, child) {
  //       return PageView.builder(
  //         allowImplicitScrolling: true, // loads images faster
  //         controller: horizontalController,
  //         itemCount: model.entires.length,
  //         scrollDirection: Axis.horizontal,
  //         itemBuilder: (context, index) {
  //           final EntryEntity entry = model.entires[index];
  //           return CarouselCard(entry: entry);
  //         },
  //       );
  //     },
  //   );
  // }
}
