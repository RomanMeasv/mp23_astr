import 'package:flutter/cupertino.dart';
import 'package:mp23_astr/models/entry_entity.dart';
import 'package:mp23_astr/providers/entry_provider_interface.dart';

class MockEntryProvider implements IEntryProvider {
  final List<EntryEntity> listEntries = [
    EntryEntity(
      id: 1,
      text: 'Avocados',
      image: const NetworkImage(
          'https://cdb.arla.com/api/assets/arla-dk/d8295979-11ac-4722-be6b-f3638d5f3cf7/avocado.jpg?width=1280&height=640&mode=cropupsize&quality=90'),
    ),
    EntryEntity(
      id: 2,
      text: 'Bryndza',
      image: const NetworkImage(
          'https://www.halusky.co.uk/media/catalog/product/cache/edca9683ab123d4b6e97d40ddde16703/b/r/bryndza_thermised_100g.jpg'),
    ),
    EntryEntity(
      id: 3,
      text: 'Cereals',
      image: const NetworkImage(
          'https://www.eatthis.com/wp-content/uploads/sites/4/2022/09/cereal-aisle.jpg?quality=82&strip=1&w=640'),
    ),
    EntryEntity(
      id: 4,
      text: 'Pasta',
      image: const NetworkImage(
          'https://resources.chainbox.io/2/condi/public/pim/2767bcad-b47d-4fea-8478-3893ed2603c0/17707-1_default.jpg'),
    ),
    EntryEntity(
      id: 5,
      text: 'Coca Cola',
      image: const NetworkImage(
          'https://billigfadoel.dk/wp-content/uploads/2018/11/Coca-Cola-25-cl-glasflaske-30-stk-bestil-hos-Billigfadoel.jpg'),
    ),
  ];

  @override
  void create(EntryEntity entity) {
    listEntries.add(entity);
  }

  @override
  void delete(EntryEntity entity) {
    listEntries.remove(entity);
  }

  @override
  List<EntryEntity> fetch() {
    return listEntries;
  }
}
