import 'package:flutter/material.dart';

class cloud extends StatelessWidget {
  const cloud({
    super.key,
    required this.cloudX1,
    required this.cloudY1,
  });

  final double cloudX1;
  final double cloudY1;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(cloudX1, cloudY1),
      child: Image.asset(
        "assets/images/MistiCloud.png",
        width: 198,
        height: 135,
        fit: BoxFit.fill,
      ),
    );
  }
}
