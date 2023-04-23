import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mp23_astr/models/entry_entity.dart';
import 'package:mp23_astr/models/entry_model.dart';
import 'package:mp23_astr/utilities/platform_helper.dart';
import 'package:mp23_astr/widgets/carousel_card.dart';
import 'package:mp23_astr/widgets/photo_taker.dart';
import 'package:provider/provider.dart';

import '../widgets/photo_remover.dart';

class Home extends StatefulWidget {
  final List<CameraDescription> cameras;
  const Home({super.key, required this.cameras});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController horizontalController = PageController();
  final PageController verticalController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    // display different pages based on platform
    final List<Widget> pages = PlatformHelper.isMobile == true
        ? List.from([
            PhotoTaker(cameras: widget.cameras),
            _buildCarousel(),
            const PhotoRemover(),
          ])
        : List.from([
            _buildCarousel(),
          ]);

    return PageView(
      allowImplicitScrolling: true,
      controller: verticalController,
      scrollDirection: Axis.vertical,
      children: pages,
    );
  }

  Widget _buildCarousel() {
    return Consumer<EntryModel>(
      builder: (context, model, child) {
        return PageView.builder(
          allowImplicitScrolling: true, // loads images faster
          controller: horizontalController,
          itemCount: model.entires.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final EntryEntity entry = model.entires[index];
            return CarouselCard(entry: entry);
          },
        );
      },
    );
  }
}
