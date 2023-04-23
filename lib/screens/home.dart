import 'package:flutter/material.dart';
import 'package:mp23_astr/models/entry_entity.dart';
import 'package:mp23_astr/models/entry_model.dart';
import 'package:mp23_astr/utilities/platform_helper.dart';
import 'package:mp23_astr/widgets/carousel_background.dart';
import 'package:mp23_astr/widgets/carousel_card.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Consumer<EntryModel>(
      builder: (context, model, child) {
        return Center(
          child: PageView.builder(
            controller: controller,
            itemCount: model.entires.length,
            itemBuilder: (context, index) {
              final EntryEntity entry = model.entires[index];
              if (PlatformHelper.isMobile) {
                // Platform specific deletion of list entries
                return Dismissible(
                  // dismissThresholds: Map.from(
                  //   {DismissDirection.up: 0.1},
                  // ),
                  movementDuration: const Duration(milliseconds: 300),
                  background: const CarouselBackground(),
                  direction: DismissDirection.up,
                  key: ObjectKey(entry),
                  onDismissed: (_) => model.remove(entry),
                  child: CarouselCard(entry: entry),
                );
              }

              // TODO: Implement screens for other platforms
              return CarouselCard(entry: entry);
            },
          ),
        );
      },
    );
  }
}
