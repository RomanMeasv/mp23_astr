import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mp23_astr/models/entry_entity.dart';
import 'package:mp23_astr/providers/entry_provider_interface.dart';

class EntryModel extends ChangeNotifier {
  late final List<EntryEntity> _listEntries;
  final IEntryProvider provider;

  UnmodifiableListView<EntryEntity> get entires =>
      UnmodifiableListView(_listEntries);

  EntryModel({required this.provider}) {
    _listEntries = provider.fetch();
  }

  void add(EntryEntity entry) {
    try {
      provider.create(entry);
      _listEntries.add(entry);
    } catch (error) {
      print(error);
    } finally {
      notifyListeners();
    }
  }

  void remove(EntryEntity entry) {
    try {
      provider.delete(entry);
      _listEntries.remove(entry);
    } catch (error) {
      print(error);
    } finally {
      notifyListeners();
    }
  }
}
