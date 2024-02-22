import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:misti/game/bird.dart';
import 'package:misti/game/scoreboard.dart';
import 'package:misti/game/start.dart';
import 'cloud.dart';

class GameHomePage extends StatefulWidget {
  final String title;

  const GameHomePage({Key? key, this.title = ''}) : super(key: key);

  @override
  State<GameHomePage> createState() => _GameHomePageState();
}

const double gapSize = 0.6;
const double g = 9.8;

class _GameHomePageState extends State<GameHomePage> {
  double birdY = 0;
  double birdYLastTime = 0;
  bool isRunning = false;
  bool timeCancel = false;
  double cloudX1 = 0.05;
  double cloudX2 = 2.5;
  double cloudY1 = 0.5;
  double cloudY2 = -0.5;

  int score = 0;
  int maxScore = 0;
  double time = 0;
  late Timer timer;

  bool checkCrash(double cloudX, double cloudY) {
    if (cloudX <= 0.05 && cloudX >= -2.35) {
      if (birdY <= cloudY + 0.35 && birdY >= cloudY - 0.3) {
        return true;
      }
    }
    if (birdY < -1.15 || birdY > 1.2) {
      return true;
    }
    return false;
  }

  startGame() {
    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      final double newCloudX1 = cloudX1 - 0.02;
      final double newCloudX2 = cloudX2 - 0.02;
      bool isCrash = false;

      time += 0.015;
      birdY = -(g / 2) * time * time + 1 * time;
      setState(() {
        birdY = birdYLastTime - birdY;
      });

      isCrash = checkCrash(cloudX1, cloudY1);
      isCrash |= checkCrash(cloudX2, cloudY2);

      if (cloudX1 <= -2.98 || cloudX2 <= -2.98) {
        setState(() {
          score += 1;
          if (score > maxScore) {
            maxScore = score;
          }
        });
      }

      if (isCrash == true) {
        setState(() {
          birdY = 0;
          birdYLastTime = 0;
          isRunning = false;
          score = 0;
          time = 0;
          cloudX1 = 0.05;
          cloudX2 = 2.5;
          cloudY1 = 0.5;
          cloudY2 = -0.5;
        });

        timer.cancel();
      } else {
        setState(() {
          if (newCloudX1 < -3) {
            cloudY1 = -1 + 2 * Random().nextDouble();
            cloudX1 = 2.5;
          } else {
            cloudX1 = newCloudX1;
          }
          if (newCloudX2 < -3) {
            cloudY2 = -1 + 2 * Random().nextDouble();
            cloudX2 = 2.5;
          } else {
            cloudX2 = newCloudX2;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 3 / 4;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flappy Bird'),
      ),
      body: GestureDetector(
          onTap: () {
            setState(() {
              if (isRunning) {
                time = 0;
                birdY -= 0.2;
                birdYLastTime = birdY;
              }
            });
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Stack(children: [
                        cloud(cloudX1: cloudX1, cloudY1: cloudY1),
                        cloud(cloudX1: cloudX2, cloudY1: cloudY2),
                        Bird(birdY: birdY),
                        Container(
                            decoration:
                                BoxDecoration(color: Colors.transparent))
                      ])),
                  Expanded(
                      flex: 1,
                      child: ScoreBoard(
                        curScore: score,
                        maxScore: maxScore,
                      ))
                ],
              ),
              if (isRunning == false)
                GestureDetector(
                    onTap: () {
                      startGame();
                    },
                    child: Container(
                      alignment: Alignment(0, -0.2),
                      child: StartScreen(),
                    ))
            ],
          )),
      backgroundColor: Colors.white,
    );
  }
}
