import 'package:flutter/material.dart';
import 'package:mp23_astr/widgets/carousel_background.dart';
import 'package:mp23_astr/widgets/carousel_card.dart';

import '../models/list_entry.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ListEntry> listEntries = [
    ListEntry(
      text: 'Avocados',
      image: const NetworkImage(
          'https://cdb.arla.com/api/assets/arla-dk/d8295979-11ac-4722-be6b-f3638d5f3cf7/avocado.jpg?width=1280&height=640&mode=cropupsize&quality=90'),
    ),
    ListEntry(
      text: 'Bryndza',
      image: const NetworkImage(
          'https://www.halusky.co.uk/media/catalog/product/cache/edca9683ab123d4b6e97d40ddde16703/b/r/bryndza_thermised_100g.jpg'),
    ),
    ListEntry(
      text: 'Cereals',
      image: const NetworkImage(
          'https://www.eatthis.com/wp-content/uploads/sites/4/2022/09/cereal-aisle.jpg?quality=82&strip=1&w=640'),
    ),
    ListEntry(
      text: 'Pasta',
      image: const NetworkImage(
          'https://resources.chainbox.io/2/condi/public/pim/2767bcad-b47d-4fea-8478-3893ed2603c0/17707-1_default.jpg'),
    ),
    ListEntry(
      text: 'Coca Cola',
      image: const NetworkImage(
          'https://billigfadoel.dk/wp-content/uploads/2018/11/Coca-Cola-25-cl-glasflaske-30-stk-bestil-hos-Billigfadoel.jpg'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Center(
      child: PageView.builder(
        controller: controller,
        itemCount: listEntries.length,
        itemBuilder: (context, index) {
          final ListEntry listEntry = listEntries[index];
          return Dismissible(
            // dismissThresholds: Map.from(
            //   {DismissDirection.up: 0.1},
            // ),
            movementDuration: const Duration(milliseconds: 300),
            background: const CarouselBackground(),
            direction: DismissDirection.up,
            key: ObjectKey(listEntry),
            onDismissed: (_) => onEntryDismissed(index),
            child: CarouselCard(entry: listEntry),
          );
        },
      ),
    );
  }

  void onEntryDismissed(index) {
    setState(() {
      listEntries.removeAt(index);
    });
  }
}
