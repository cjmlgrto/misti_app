import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: 92,
        height: 48,
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
