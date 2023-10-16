import 'package:flutter/material.dart';

import 'package:app_template/constants.dart';

class Base extends StatelessWidget {
  final Widget child;

  const Base({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
            child: Padding(padding: const EdgeInsets.all(16), child: child)));
  }
}
