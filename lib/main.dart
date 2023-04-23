import 'package:flutter/material.dart';
import 'package:mp23_astr/models/entry_model.dart';
import 'package:mp23_astr/providers/mock_entry_provider.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';

void main() {
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
      home: const Scaffold(
        body: Home(),
      ),
    );
  }
}
