import 'package:flutter/material.dart';
import 'package:app_template/constants.dart';

class StatusScreen extends StatelessWidget {
  final String text;

  const StatusScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background, body: Center(child: Text(text)));
  }
}
