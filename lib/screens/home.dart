import 'package:flutter/material.dart';
import 'package:mp23_astr/models/entry_entity.dart';
import 'package:mp23_astr/utilities/platform_helper.dart';
import 'package:mp23_astr/widgets/carousel_background.dart';
import 'package:mp23_astr/widgets/carousel_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Center(
      child: PageView.builder(
        controller: controller,
        itemCount: listEntries.length,
        itemBuilder: (context, index) {
          final EntryEntity listEntry = listEntries[index];
          if (PlatformHelper.isMobile) {
            // Platform specific deletion of list entries
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
          }

          // TODO: Implement screens for other platforms
          return CarouselCard(entry: listEntry);
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
