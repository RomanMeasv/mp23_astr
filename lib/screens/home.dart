import 'package:flutter/material.dart';
import 'package:mp23_astr/widgets/carousel_card.dart';

import '../models/list_entry.dart';

class Home extends StatefulWidget {
  // In Flutter it complains when you use the new keyword??
  final List<ListEntry> listEntries = [
    ListEntry(
      text: 'Item1',
      image: const NetworkImage('https://picsum.photos/id/1/500'),
    ),
    ListEntry(
      text: 'Item2',
      image: const NetworkImage('https://picsum.photos/id/2/500'),
    ),
    ListEntry(
      text: 'Item3',
      image: const NetworkImage('https://picsum.photos/id/3/500'),
    ),
    ListEntry(
      text: 'Item4',
      image: const NetworkImage('https://picsum.photos/id/4/500'),
    ),
    ListEntry(
      text: 'Item5',
      image: const NetworkImage('https://picsum.photos/id/5/500'),
    ),
  ];

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 1);

    return Center(
      child: PageView.builder(
        controller: controller,
        itemCount: widget.listEntries.length,
        itemBuilder: (context, index) {
          ListEntry listEntry = widget.listEntries[index];
          return CarouselCard(entry: listEntry);
        },
      ),
    );
  }
}
