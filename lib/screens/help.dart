import 'package:flutter/material.dart';

import 'package:misti/constants.dart';

class HelpScreen extends StatelessWidget {
  final String helpTitle;
  final String helpText;

  const HelpScreen(
      {super.key, required this.helpTitle, required this.helpText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.accentPrimary,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              helpTitle,
              style: TextStyles.title,
            ),
          ),
          Text(helpText, style: TextStyles.body)
        ]),
      )),
    );
  }
}
