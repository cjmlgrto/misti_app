import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';
import 'package:flame/text.dart';
import 'package:flutter/foundation.dart';
import 'package:misti/core/configs/constants/app_router.dart';
import 'package:misti/core/configs/theme/app_colors.dart';
import 'package:misti/game/fruit_cutting_game/main_router_game.dart';
import 'package:misti/presentation/game/game.dart';
import 'package:path_provider/path_provider.dart';

/// This class represents the route for the Game Over screen.
class GameOverRoute extends Route {
  /// Constructor for GameOverRoute, setting it to show GameOverPage.
  GameOverRoute() : super(GameOverPage.new, transparent: true);

  /// When this route is pushed, stop the game time and apply a gray effect to the background.
  @override
  void onPush(Route? previousRoute) {
    previousRoute!
      ..stopTime() // Stops the game's time.
      ..addRenderEffect(
        // Adds a visual effect to the background.
        PaintDecorator.grayscale(opacity: 0.5) // Makes the background gray.
          ..addBlur(3.0), // Adds a blur effect.
      );
  }

  /// When this route is popped (removed), resume game time and remove effects.
  @override
  void onPop(Route nextRoute) {
    // Find any children routes that are of type GamePage.
    final routeChildren = nextRoute.children.whereType<GamePage>();
    if (routeChildren.isNotEmpty) {
      final gamePage = routeChildren.first; // Get the first GamePage.
      gamePage
          .removeAll(gamePage.children); // Remove all components from GamePage.
    }

    nextRoute
      ..resumeTime() // Resumes the game's time.
      ..removeRenderEffect(); // Removes the visual effects.
  }
}

/// This class represents the Game Over page displayed after the game ends.
class GameOverPage extends Component
    with TapCallbacks, HasGameReference<MainRouterGame> {
  late TextComponent
      _textComponent; // Text component to show the game over message.
  late TextComponent _textTimeComponent;
  late TextComponent _textScoreComponent;
  late TextComponent _textNewGameComponent;
  late TextComponent _textGameModeComponent;

  /// Load the components for the Game Over page.
  @override
  FutureOr<void> onLoad() {
    final textTitlePaint = TextPaint(
      style: const TextStyle(
        fontSize: 60,
        color: AppColors.white,
        fontFamily: 'Insan',
        letterSpacing: 2.0,
      ),
    );

    final textTimePaint = TextPaint(
      style: TextStyle(
        fontSize: game.isDesktop ? 25 : 18,
        color: AppColors.white,
        fontFamily: 'Insan',
        letterSpacing: 2.0,
      ),
    );

    final textPaint = TextPaint(
      style: TextStyle(
        fontSize: game.isDesktop ? 18 : 12,
        color: AppColors.white,
        fontFamily: 'Insan',
        letterSpacing: 2.0,
      ),
    );

    final textScorePaint = TextPaint(
      style: const TextStyle(
        fontSize: 35,
        color: AppColors.white,
        fontFamily: 'Insan',
        letterSpacing: 2.0,
      ),
    );

    final flameGame = findGame()!; // Find the current game instance.

    // Add the text component to display "Game Over".
    addAll(
      [
        _textComponent = TextComponent(
          text: 'Game Over',
          // The message to display.
          position: flameGame.canvasSize / 2,
          // Center the text on the canvas.
          anchor: Anchor.center,
          // Set the anchor point to the center.
          children: [
            // Add a scaling effect to the text.
            ScaleEffect.to(
              Vector2.all(1.1), // Scale the text up to 110%.
              EffectController(
                duration: 0.3, // Duration of the scaling effect.
                alternate: true, // Make the effect go back and forth.
                infinite: true, // Repeat the effect forever.
              ),
            ),
          ],

          textRenderer: textTitlePaint,
        ),
        _textTimeComponent = TextComponent(
          text: "", // The message to display.
          position: flameGame.canvasSize / 2, // Center the text on the canvas.
          anchor: Anchor.centerLeft, // Set the anchor point to the center.
          textRenderer: textTimePaint,
        ),
        _textNewGameComponent = TextComponent(
          text: "Click anywhere to start new Game",
          position: flameGame.canvasSize / 2,
          anchor: game.isDesktop ? Anchor.centerRight : Anchor.center,
          textRenderer: textPaint,
        ),
        _textScoreComponent = TextComponent(
          text: 'Score: ',
          position: flameGame.canvasSize / 2,
          anchor: Anchor.center,
          textRenderer: textScorePaint,
        ),
        _textGameModeComponent = TextComponent(
          text:
              "Misti Games",
          position: flameGame.canvasSize / 2,
          anchor: game.isDesktop ? Anchor.centerLeft : Anchor.center,
          textRenderer: textPaint,
        ),
      ],
    );
  }

  /// Called when the game is resized; updates text position to stay centered.
  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _textComponent.position = Vector2(game.size.x / 2, game.size.y / 2 - 70);
    _textTimeComponent.position = Vector2(15, 20);
    _textScoreComponent.position =
        Vector2(game.size.x / 2, game.size.y / 2 + 25);
    _textScoreComponent.text = 'Score: ${game.getScore()}';

    _textNewGameComponent.position = game.isDesktop
        ? Vector2(game.size.x - 15, game.size.y - 15)
        : Vector2(game.size.x / 2, game.size.y - 15);
    _textGameModeComponent.position = game.isDesktop
        ? Vector2(15, game.size.y - 15)
        : Vector2(game.size.x / 2, game.size.y - 30);
  }

  /// Always returns true, indicating that this component can contain tap events.
  @override
  bool containsLocalPoint(Vector2 point) {
    return true; // Accept all tap events.
  }

  /// Handle tap up events; navigate to the home page when tapped.
  @override
  void onTapUp(TapUpEvent event) {
    game.router
      ..pop() // Go back to the previous route.
      ..pushNamed(AppRouter.homePage,
          replace: true); // Push the home page route.
  }

  Future<void> captureAndSaveImage() async {
    try {
      final PictureRecorder recorder = PictureRecorder();
      final Rect rect = Rect.fromLTWH(0.0, 0.0, game.size.x, game.size.y);
      final Canvas c = Canvas(recorder, rect);

      game.render(c);

      final Image image = await recorder
          .endRecording()
          .toImage(game.size.x.toInt(), game.size.y.toInt());
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/screenshot.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(pngBytes);
      // ignore: empty_catches
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
