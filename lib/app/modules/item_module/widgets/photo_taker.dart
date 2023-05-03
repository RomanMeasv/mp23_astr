// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PhotoTaker extends StatefulWidget {
//   const PhotoTaker({super.key});

//   @override
//   State<PhotoTaker> createState() => _PhotoTakerState();
// }

// class _PhotoTakerState extends State<PhotoTaker> {
//   late CameraController _controller;
//   late List<CameraDescription> cameras;
//   var selectedCameraIndex = 0.obs;

//   late Future<void> _initializeControllerFuture;
//   XFile? image;

//   @override
//   void initState() {
//     super.initState();
//     // To display the current output from the Camera,
//     // create a CameraController.
//     _controller = CameraController(
//       // Get a specific camera from the list of available cameras.
//       widget.camera,
//       // Define the resolution to use.
//       ResolutionPreset.max,
//     );
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // if we don't have an image, we display the photo taker widget
//     if (image == null) {
//       return _buildPhotoTaker();
//     } else {
//       return _buildPhotoEditor();
//     }
//   }

//   Widget _buildPhotoTaker() {
//     return Scaffold(
//       // You must wait until the controller is initialized before displaying the
//       // camera preview. Use a FutureBuilder to display a loading spinner until the
//       // controller has finished initializing.
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             // If the Future is complete, display the preview.
//             return _buildFullWidth(
//               CameraPreview(
//                 _controller,
//               ),
//             );
//           } else {
//             // Otherwise, display a loading indicator.
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: FloatingActionButton(
//           backgroundColor: Colors.white,
//           // Provide an onPressed callback.
//           onPressed: () async {
//             // Take the Picture in a try / catch block. If anything goes wrong,
//             // catch the error.
//             try {
//               // Ensure that the camera is initialized.
//               await _initializeControllerFuture;

//               // Attempt to take a picture and get the file `image`
//               // where it was saved.
//               image = await _controller.takePicture();

//               if (!mounted) return;

//               setState(() {});
//             } catch (e) {
//               // If an error occurs, log the error to the console.
//               print(e);
//             }
//           },
//           child: const Icon(Icons.camera_alt),
//         ),
//       ),
//     );
//   }

//   Widget _buildPhotoEditor() {
//     File imageFile = File(image!.path);
//     return Scaffold(
//       body: _buildFullWidth(
//         Image.file(
//           imageFile,
//         ),
//       ),
//     );
//   }

//   Widget _buildFullWidth(Widget child) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       child: child,
//     );
//   }
// }
