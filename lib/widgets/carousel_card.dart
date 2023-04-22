import 'package:flutter/material.dart';

import '../models/list_entry.dart';
import '../utilities/card_size.dart';

class CarouselCard extends StatelessWidget {
  static const double _textHeight = 80.0;
  final ListEntry entry;

  const CarouselCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    double width = CardSizeHelper.getCardWidth(context);
    double height = CardSizeHelper.getCardHeight(context);

    return Card(
      margin: EdgeInsets.zero,
      // Sized Box is here for width and height constraints for the card (our main UI element)
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              child: Image(
                image: entry.image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: height - _textHeight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(entry.text),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
