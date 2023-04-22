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
  // In Flutter it complains when you use the new keyword??
  final List<ListEntry> listEntries = [
    ListEntry(
      text: 'Item1',
      image: const NetworkImage('https://picsum.photos/id/1/1920'),
    ),
    ListEntry(
      text: 'Item2',
      image: const NetworkImage('https://picsum.photos/id/2/1920'),
    ),
    ListEntry(
      text: 'Item3',
      image: const NetworkImage('https://picsum.photos/id/3/1920'),
    ),
    ListEntry(
      text: 'Item4',
      image: const NetworkImage('https://picsum.photos/id/4/1920'),
    ),
    ListEntry(
      text: 'Item5',
      image: const NetworkImage('https://picsum.photos/id/5/1920'),
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
