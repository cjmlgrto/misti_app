
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:misti/screens/flappyBirdGame/game_over_screen.dart';
import 'package:misti/screens/flappyBirdGame/main_menu_screen.dart';
import 'flappy_bird_game.dart';

class Game01 extends StatelessWidget {
  const Game01({super.key});

  @override
  Widget build(BuildContext context) {

    // Initialize Flame device settings
    WidgetsFlutterBinding.ensureInitialized();
    Flame.device.setPortrait();

    final game = FlappyBirdGame();
    final maxHeight = MediaQuery.of(context).size.height * 1 ;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF), // White background
        title: const Text(
          'Misti games: Baby Bounce',
          style: TextStyle(
            fontSize: 16, // Font size 16px
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black), // Optional: if there are icons
      ),
      body: SizedBox(
        height: maxHeight,
        child: GameWidget(
          game: game,
          initialActiveOverlays: const [MainMenuScreen.id],
          overlayBuilderMap: {
            'mainMenu': (context, _) => MainMenuScreen(game: game),
            'gameOver': (context, _) => GameOverScreen(game: game),
          },
        ),
      ),
    );
  }
}