import 'package:flutter/material.dart';

class CarouselBackground extends StatelessWidget {
  static const Color _mainColor = Colors.red;
  static const Color _secondaryColor = Colors.white;
  static const String _text = "Remove from list";

  const CarouselBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _mainColor,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Icon(
              Icons.delete,
              color: _secondaryColor,
              size: 72.0,
            ),
            Text(
              _text,
              style: TextStyle(
                color: _secondaryColor,
                fontSize: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
