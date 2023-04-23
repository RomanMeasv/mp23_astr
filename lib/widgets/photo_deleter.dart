import 'package:flutter/material.dart';

class PhotoDeleter extends StatelessWidget {
  static const Color _mainColor = Colors.red;
  static const Color _secondaryColor = Colors.white;
  static const String _text = "Remove from list";

  const PhotoDeleter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      color: _mainColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
