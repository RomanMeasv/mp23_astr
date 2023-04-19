import 'package:flutter/material.dart';

class CardSizeHelper {
  static const double _cardWidth = 1024.0;
  static const double _cardHeight = 768;

  static double getCardWidth(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > _cardWidth ? _cardWidth : screenWidth;
  }

  static double getCardHeight(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return screenHeight > _cardHeight ? _cardHeight : screenHeight;
  }
}
