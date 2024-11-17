import 'package:misti/game/flappyBirdGame/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget{
  final FlappyBirdGame game;
  static const String id = "mainMenu";

  const MainMenuScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();

    return Scaffold(
      body: GestureDetector(
        onTap: (){
          game.overlays.remove('mainMenu');
          game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/flappyBirdGames/menu.png'),
              fit: BoxFit.cover,
            ),
          ),

          child: Image.asset(
            "assets/images/flappyBirdGames/message.png",
          ),

        ),
      ),
    );
  }
}
