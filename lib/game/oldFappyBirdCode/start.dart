import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(child:const Text("Tap to Start Game",
        style: TextStyle(fontSize: 32, color: Colors.green)
    ));
  }
}