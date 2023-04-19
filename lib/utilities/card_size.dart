import 'package:flutter/material.dart';

class CardSizeHelper {
  static const double _cardWidth = 500.0;
  static const double _cardHeight = 900.0;

  static double getCardWidth(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > _cardWidth ? _cardWidth : screenWidth;
  }

  static double getCardHeight(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return screenHeight > _cardHeight ? _cardHeight : screenHeight;
  }
}
