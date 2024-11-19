import 'dart:ui';
import 'dart:async';
import 'dart:io';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

import 'package:flame/game.dart' hide Game; // Hides the Game class to avoid naming conflicts.
import 'package:flame/rendering.dart';
import 'package:flame/text.dart';
import 'package:flutter/foundation.dart';
import 'package:misti/common/helpers/app_save_action.dart';
import 'package:misti/common/widgets/button/rounded_button.dart';
import 'package:misti/core/configs/constants/app_router.dart';
import 'package:misti/core/configs/theme/app_colors.dart';
import 'package:misti/game/fruit_cutting_game/main_router_game.dart';
import 'package:path_provider/path_provider.dart';

/// This class represents the route for the pause screen in the game.
class VictoryRoute extends Route {
  /// Constructor for VictoryRoute, sets it to show GameVictoryPage.
  VictoryRoute() : super(GameVictoryPage.new, transparent: true);

  /// When this route is pushed (opened), stop the game time and apply a gray effect to the background.
  @override
  void onPush(Route? previousRoute) {
    previousRoute!
      ..stopTime() // Stops the game's time.
      ..addRenderEffect(
        // Adds a visual effect to the background.
        PaintDecorator.grayscale(opacity: 0.5) // Makes the background gray.
          ..addBlur(3.0), // Adds a blur effect to the background.
      );
  }

  /// When this route is popped (closed), resume game time and remove effects.
  @override
  void onPop(Route nextRoute) {
    nextRoute
      ..resumeTime() // Resumes the game's time.
      ..removeRenderEffect(); // Removes the visual effects from the background.
  }
}

/// This class represents the pause page displayed when the game is paused.
class GameVictoryPage extends Component with TapCallbacks, HasGameReference<MainRouterGame> {
  late TextComponent _textComponent; // Text component to show the "VICTORY" message.
  late TextComponent _textTimeComponent;
  late TextComponent _textScoreComponent;
  late TextComponent _textLeaderboardComponent;
  late TextComponent _textGameModeComponent;

  late RoundedButton _buttonNewGameComponent;

  /// Load the components for the pause page.
  @override
  Future<void> onLoad() async {
    final textTitlePaint = TextPaint(
      style: const TextStyle(
        fontSize: 80,
        color: AppColors.white,
        fontFamily: 'Marshmallow',
        letterSpacing: 3.0,
      ),
    );

    final textPaint = TextPaint(
      style: const TextStyle(
        fontSize: 15,
        color: AppColors.white,
        fontFamily: 'Insan',
        letterSpacing: 2.0,
      ),
    );

    final textTimePaint = TextPaint(
      style: const TextStyle(
        fontSize: 25,
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

    _buttonNewGameComponent = RoundedButton(
      bgColor: AppColors.githubColor,
      borderColor: AppColors.blue,
      text: "New Game",
      anchor: Anchor.center,
      onPressed: () {
        game.router
          ..pop() // Go back to the previous route.
          ..pushNamed(AppRouter.homePage, replace: true); // Push the home page route.
      },
    );

    add(_buttonNewGameComponent);

    final flameGame = findGame()!; // Find the current game instance.

    // Add the text component to display "VICTORY".
    addAll(
      [
        _textComponent = TextComponent(
          text: 'VICTORY', // The message to display when the flameGame is paused.
          position: flameGame.canvasSize / 2, // Center the text on the canvas.
          anchor: Anchor.center, // Set the anchor point to the center of the text.
          children: [
            // Add a scaling effect to the text to make it pulsate.
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
        _textLeaderboardComponent = TextComponent(
          text: "Click anywhere to save Rankings",
          position: flameGame.canvasSize / 2,
          anchor: Anchor.centerRight,
          textRenderer: textPaint,
        ),
        _textScoreComponent = TextComponent(
          text: 'Score: ',
          position: flameGame.canvasSize / 2,
          anchor: Anchor.center,
          textRenderer: textScorePaint,
        ),
        _textGameModeComponent = TextComponent(
          text: "Mode: ${game.mode == 0 ? 'Easy' : game.mode == 1 ? 'Medium' : 'Hard'}",
          position: flameGame.canvasSize / 2,
          anchor: Anchor.centerLeft,
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
    _textScoreComponent.position = Vector2(game.size.x / 2, game.size.y / 2 + 25);
    _buttonNewGameComponent.position = Vector2(game.size.x / 2, game.size.y / 2 + 110);
    _textLeaderboardComponent.position = Vector2(game.size.x - 15, game.size.y - 15);
    _textGameModeComponent.position = Vector2(15, game.size.y - 15);

    _textScoreComponent.text = 'Score: ${game.getScore()}';
  }

  /// Always returns true, indicating that this component can contain tap events.
  @override
  bool containsLocalPoint(Vector2 point) {
    return true; // Accept all tap events.
  }


  /// Handle tap up events; navigate back to the previous screen when tapped.
  @override
  Future<void> onTapUp(TapUpEvent event) async {
    await captureAndSaveImage();
    final GitHubService gitHubService = GitHubService(
      time: _textTimeComponent.text,
      score: game.getScore().toString(),
      mode: game.mode.toString(),
      win: true,
    );
    gitHubService.createIssue();
  }

  Future<void> captureAndSaveImage() async {
    try {
      final PictureRecorder recorder = PictureRecorder();
      final Rect rect = Rect.fromLTWH(0.0, 0.0, game.size.x, game.size.y);
      final Canvas c = Canvas(recorder, rect);

      game.render(c);

      final Image image = await recorder.endRecording().toImage(game.size.x.toInt(), game.size.y.toInt());
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
