import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart' hide Game;
import 'package:misti/game/fruit_cutting_game/main_router_game.dart';
import 'web_title_switcher_stub.dart' if (dart.library.html) 'web_title_switcher_web.dart';

class Game02 extends StatelessWidget {
  const Game02({super.key}); // Super key for navigation purposes.

  @override
  Widget build(BuildContext context) {
    // Initialize Flame device settings
    WidgetsFlutterBinding.ensureInitialized();
    Flame.device.fullScreen();
    Flame.device.setLandscape();

    return WebTitleSwitcher(
      child: GameWidget(
        game: MainRouterGame(),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Game02(), // Set Game02 as the default home widget
  ));
}
