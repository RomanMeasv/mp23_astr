import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mp23_astr/models/entry_model.dart';
import 'package:mp23_astr/providers/mock_entry_provider.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    ChangeNotifierProvider(
      create: (context) => EntryModel(provider: MockEntryProvider()),
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: Home(camera: firstCamera),
        ),
      ),
    ),
  );
}
