import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  const Bird({
    super.key,
    required this.birdY,
  });

  final double birdY;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 0),
        curve: Curves.linearToEaseOut,
        alignment: Alignment(-0.8, birdY),
        child: Container(
            width: 120,
            height: 120,
            child: Image.asset("assets/images/Pillow.png")));
  }
}
