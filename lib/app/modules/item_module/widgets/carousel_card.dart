import 'package:flutter/material.dart';
import 'package:mp23_astr/core/utils/card_size.dart';

class CarouselCard extends StatelessWidget {
  static const double _textHeight = 120.0;

  var item;

  CarouselCard({required this.item, super.key});

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
                image: NetworkImage(item.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: height - _textHeight,
              bottom: 0,
              left: 0,
              right: 0,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                // TODO: add some kind of shadow so the text is visible at all times
                child: Text(
                  'Cereals',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
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
