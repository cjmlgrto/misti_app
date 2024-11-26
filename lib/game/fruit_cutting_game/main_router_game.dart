import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:misti/core/configs/assets/app_images.dart';
import 'package:misti/core/configs/assets/app_sfx.dart';
import 'package:misti/core/configs/constants/app_configs.dart';
import 'package:misti/core/configs/constants/app_router.dart';
import 'package:misti/data/models/fruit_model.dart';
import 'package:misti/presentation/game/game.dart';
import 'package:misti/presentation/game_over/game_over.dart';
import 'package:misti/presentation/game_pause/game_pause.dart';
import 'package:misti/presentation/game_victory/game_victory.dart';
import 'package:misti/presentation/home/home.dart';

/// Main game class that extends FlameGame
class MainRouterGame extends FlameGame with KeyboardEvents {
  final Random random = Random();
  late final RouterComponent router;
  late double maxVerticalVelocity;

  // List of available fruits in the game
  final List<FruitModel> fruits = [
    FruitModel(image: AppImages.apple),
    FruitModel(image: AppImages.banana),
    FruitModel(image: AppImages.kiwi),
    FruitModel(image: AppImages.orange),
    FruitModel(image: AppImages.peach),
    FruitModel(image: AppImages.pineapple),
    FruitModel(image: AppImages.watermelon),
    FruitModel(image: AppImages.cherry),
    FruitModel(image: AppImages.bomb, isBomb: true),
    FruitModel(image: AppImages.flame, isBomb: true),
    FruitModel(image: AppImages.flutter, isBomb: true),
  ];

  void startBgmMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play(AppSfx.musicBG, volume: 0.3);
  }

  bool isDesktop = false; // Current state of the screen

  int score = 0; // Current score of the player

  /// Retrieves the current score.
  ///
  /// Returns the current score value.
  int getScore() {
    return score;
  }

  /// Saves the input score.
  ///
  /// Updates the score with the provided scoreInput value.
  void saveScore(int scoreInput) {
    score = scoreInput;
  }

  int mode = 0; // Current game mode (0, 1, 2, etc.)

  /// Retrieves the current game mode.
  ///
  /// Returns the current mode value.
  int getMode() {
    return mode;
  }

  /// Saves the input mode.
  ///
  /// Updates the mode with the provided modeInput value.
  void saveMode(int modeInput) {
    mode = modeInput;
  }

  @override
  void onLoad() async {
    super.onLoad();

    for (final fruit in fruits) {
      await images.load(fruit.image);
    }

    await images.load(AppImages.homeBG);

    addAll(
      [
        ParallaxComponent(
          parallax: Parallax(
            [
              await ParallaxLayer.load(
                ParallaxImageData(AppImages.homeBG),
              ),
            ],
          ),
        ),
        // Set up the router for navigating between different game screens.
        router = RouterComponent(
          initialRoute: AppRouter.homePage,
          routes: {
            AppRouter.homePage: Route(HomePage.new),
            AppRouter.gamePage: Route(GamePage.new),
            AppRouter.gameVictory: VictoryRoute(),
            AppRouter.gameOver: GameOverRoute(),
            AppRouter.gamePause: PauseRoute(),
          },
        )
      ],
    );
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    getMaxVerticalVelocity(size);
  }

  /// Calculate the maximum vertical velocity based on the game size.
  void getMaxVerticalVelocity(Vector2 size) {
    // Formula to calculate maximum vertical velocity.
    // Adjust for the object's size.
    maxVerticalVelocity = sqrt(2 * (AppConfig.gravity.abs() + AppConfig.acceleration.abs()) * (size.y - AppConfig.objSize * 2));
  }
}

