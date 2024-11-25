import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart' hide Game;
import 'package:misti/game/fruit_cutting_game/main_router_game.dart';
import 'package:misti/screens/demo.dart';
import 'package:flutter/services.dart'; // Import for SystemChrome
import 'web_title_switcher_stub.dart'
    if (dart.library.html) 'web_title_switcher_web.dart';

class Game02 extends StatefulWidget {
  const Game02({super.key}); // Super key for navigation purposes.

  @override
  State<Game02> createState() => _Game02State();
}

class _Game02State extends State<Game02> {
  @override
  void initState() {
    super.initState();

    // Force landscape orientation and fullscreen for this screen
    Flame.device.fullScreen();
    Flame.device.setLandscape();
  }

  @override
  void dispose() {
    super.dispose();

    // Reset orientation to allow portrait mode when leaving this screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Flame.device.setPortrait();
  }

  @override
  Widget build(BuildContext context) {
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
            top: 15, // Set top position to 15
            left: (MediaQuery.of(context).size.width - 60) /
                2, // Center horizontally
            child: GestureDetector(
              onTap: () {
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
