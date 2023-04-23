import '../models/entry_entity.dart';

abstract class IEntryProvider {
  void create(EntryEntity entity);
  void delete(EntryEntity entity);
  List<EntryEntity> fetch();
}
