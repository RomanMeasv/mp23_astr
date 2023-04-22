import 'package:flutter/material.dart';
import 'package:mp23_astr/models/entry_entity.dart';
import 'package:mp23_astr/providers/entry_provider_interface.dart';

class EntryModel extends ChangeNotifier {
  final List<EntryEntity> _listEntries = [];
  late IEntryProvider _provider;

  void add(EntryEntity entry) {
    try {
      _provider.create(entry);
      _listEntries.add(entry);
    } catch (error) {
      print(error);
    } finally {
      notifyListeners();
    }
  }

  void remove(EntryEntity entry) {
    try {
      _provider.delete(entry);
      _listEntries.remove(entry);
    } catch (error) {
      print(error);
    } finally {
      notifyListeners();
    }
  }
}
