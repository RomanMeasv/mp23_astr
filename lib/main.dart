import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mp23_astr/models/entry_model.dart';
import 'package:mp23_astr/providers/mock_entry_provider.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';

late List<CameraDescription> _cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(ChangeNotifierProvider(
    create: (context) => EntryModel(provider: MockEntryProvider()),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Home(cameras: _cameras),
      ),
    );
  }
}
