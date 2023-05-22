import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/data/model/item.dart';
import 'package:mp23_astr/core/utils/card_size.dart';

class CarouselCard extends StatelessWidget {
  static const double _textHeight = 200.0;

  final ItemModel item;

  const CarouselCard({required this.item, super.key});

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
              height: Get.height,
              width: Get.width,
              child: Image(
                image: NetworkImage(item.imageUrl!),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: height - _textHeight,
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                // TODO: add some kind of shadow so the text is visible at all times
                child: Text(
                  item.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
