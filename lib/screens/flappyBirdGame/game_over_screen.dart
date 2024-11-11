import 'package:misti/game/flappyBirdGame/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  static const String id = 'gameOver';
  final FlappyBirdGame game;

  const GameOverScreen({super.key, required this.game});



  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score: ${game.bird.score}',
              style: const TextStyle(
                fontSize: 60,
                color: Colors.white,
                fontFamily: 'Bold',
              ),
            ),

            const SizedBox(height: 20,),


            Image.asset('assets/images/gameover.png'),
            const SizedBox(height: 20,),

            ElevatedButton(
                onPressed: onRestart,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text(
                  'Restart',
                  style: TextStyle(fontSize: 20 , color: Colors.white),

                )
            )

          ],
        ),
      ),
    );
  }

  void onRestart(){
    game.bird.reset();
    game.overlays.remove('gameOver');
    game.resumeEngine();

  }
}
