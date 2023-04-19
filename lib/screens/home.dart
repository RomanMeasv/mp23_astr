import 'package:flutter/material.dart';
import 'package:mp23_astr/utilities/card_size.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const double textHeight = 80.0;

  @override
  Widget build(BuildContext context) {
    double width = CardSizeHelper.getCardWidth(context);
    double height = CardSizeHelper.getCardHeight(context);

    return Center(
      child: Card(
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              const SizedBox(
                height: double.infinity,
                child: Image(
                  image: AssetImage("lib/assets/image_placeholder.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: height - textHeight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Lorem Ipsum Lorem Ipsum"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
