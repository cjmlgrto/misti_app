import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart' hide Game;
import 'package:misti/game/flappyBirdGame/game01.dart';
import 'package:flutter/services.dart';
import 'package:misti/game/fruit_cutting_game/main_router_game.dart';
import 'package:misti/main.dart';
import 'package:misti/screens/demo.dart';
import 'web_title_switcher_stub.dart' if (dart.library.html) 'web_title_switcher_web.dart';

class Game02 extends StatelessWidget {
  const Game02({super.key}); // Super key for navigation purposes.

  @override
  Widget build(BuildContext context) {
    // Initialize Flame device settings
    WidgetsFlutterBinding.ensureInitialized();
    Flame.device.fullScreen();
    Flame.device.setLandscape();

    return Scaffold(
      body: Stack(
        children: [
          // Game widget (Main content)
          WebTitleSwitcher(
            child: GameWidget(
              game: MainRouterGame(),
            ),
          ),

          // Small clickable image positioned at the top-left corner
          Positioned(
            top: 15, // Set top position to 20
            left: (MediaQuery.of(context).size.width-60) / 2, // Center horizontally
            child: GestureDetector(
              onTap: () {
                Flame.device.setPortrait();
                // Navigate to the main/home screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DemoScreen()),
                );
              },
              child: Image.asset(
                'assets/images/mainMenuButton.png', // Path to your image
                width: 68,
                height: 27,
              ),
            ),
          )

        ],
      ),
    );
  }
}

