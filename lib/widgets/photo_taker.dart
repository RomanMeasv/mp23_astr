import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PhotoTaker extends StatefulWidget {
  final List<CameraDescription> cameras;
  const PhotoTaker({super.key, required this.cameras});

  @override
  State<PhotoTaker> createState() => _PhotoTakerState();
}

class _PhotoTakerState extends State<PhotoTaker> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors
            break;
          default:
            // Handle other errors
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Placeholder();
    }
    return CameraPreview(controller);
  }
}
