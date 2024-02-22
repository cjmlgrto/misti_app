import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final int curScore;
  final int maxScore;
  const ScoreBoard({
    super.key,
    required this.curScore,
    required this.maxScore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/ground.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Current Score",
                    style: TextStyle(fontSize: 20, color: Colors.green)),
                Text(curScore.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.green))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Highest Score",
                    style: TextStyle(fontSize: 20, color: Colors.red)),
                Text(maxScore.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.red))
              ],
            )
          ],
        ));
  }
}
