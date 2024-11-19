import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/text.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:misti/common/widgets/button/back_button.dart';
import 'package:misti/common/widgets/button/pause_button.dart';
import 'package:misti/core/configs/assets/app_sfx.dart';
import 'package:misti/core/configs/theme/app_colors.dart';
import 'package:misti/presentation/game/widgets/fruit_component.dart';
import 'package:misti/core/configs/constants/app_configs.dart';
import 'package:misti/core/configs/constants/app_router.dart';
import 'package:misti/game/fruit_cutting_game/main_router_game.dart';
import 'package:misti/presentation/game/widgets/fruit_slice_component.dart';
import 'package:misti/presentation/game/widgets/slice_component.dart';

/// The main game page where the game play happens.
class GamePage extends Component with DragCallbacks, HasGameReference<MainRouterGame> {
  // Random number generator for fruit timings
  final Random random = Random();
  late List<double> fruitsTime; // List to hold the timing for when fruits appear

  // Timing variables
  late double time; // Current elapsed time
  late double countDown; // Countdown timer for the start of the game
  double finishCountDown = 2.0; // Finish countdown duration

  // Game variables
  late int level = 1; // Current game level
  late int mistakeCount; // Number of mistakes made by the player
  late int score; // Player's score
  bool _countdownFinished = false; // Flag to check if countdown is finished

  // UI Components
  TextComponent? _countdownTextComponent; // Component to display countdown
  TextComponent? _mistakeTextComponent; // Component to display mistake count
  TextComponent? _scoreTextComponent; // Component to display score
  TextComponent? _modeTextComponent;

  // Slash effect
  late SliceTrailComponent sliceTrail;
  final List<String> sliceSounds = [AppSfx.sfxChopping, AppSfx.sfxCut];

  /// Called when the component is added to the game.
  @override
  void onMount() {
    super.onMount();

    // Initialize game variables
    fruitsTime = []; // List to store timings for fruit appearances
    countDown = 5; // Start countdown from 3 seconds
    mistakeCount = 0; // Initialize mistake count to zero (no mistakes at the start)
    score = 0; // Set initial score to zero
    time = 0; // No time has passed at the start
    _countdownFinished = false; // Countdown has not finished yet
    level = 1;

    generateFruitTimings();

    // Initialize text components for score, countdown, mistakes
    initializeTextComponents();

    sliceTrail = SliceTrailComponent();
    add(sliceTrail);
  }

  void initializeTextComponents() {
    final scoreTextPaint = TextPaint(
      style: TextStyle(
        fontSize: game.isDesktop ? 32 : 25,
        color: AppColors.white,
        fontWeight: FontWeight.w100,
        fontFamily: 'Insan',
        letterSpacing: 2.0,
      ),
    );

    final countdownTextPaint = TextPaint(
      style: const TextStyle(
        fontSize: 45,
        color: AppColors.white,
        fontFamily: 'Insan',
        letterSpacing: 2.0,
      ),
    );

    final mistakeTextPaint = TextPaint(
      style: TextStyle(
        fontSize: game.isDesktop ? 32 : 25,
        color: AppColors.white,
        fontWeight: FontWeight.w100,
        fontFamily: 'Insan',
        letterSpacing: 2.0,
      ),
    );

    final modeTextPaint = TextPaint(
      style: const TextStyle(
        fontSize: 18,
        color: AppColors.white,
        fontWeight: FontWeight.w100,
        fontFamily: 'Insan',
        letterSpacing: 2.0,
      ),
    );

    // Add game components to the page
    addAll([
      BackButtonCustom(
        onPressed: () {
          removeAll(children);
          game.router.pop();
        },
      ),
      PauseButtonCustom(),
      _countdownTextComponent = TextComponent(
        text: "- Level 1 -",
        size: Vector2.all(50),
        position: Vector2(game.size.x / 2, game.size.y / 2 - 10),
        anchor: Anchor.center,
        textRenderer: countdownTextPaint,
      ),
      _mistakeTextComponent = TextComponent(
        text: 'Mistake: $mistakeCount',
        position: Vector2(game.size.x - 15, 10),
        anchor: Anchor.topRight,
        textRenderer: mistakeTextPaint,
      ),
      _scoreTextComponent = TextComponent(
        text: 'Score: $score',
        position: Vector2(game.size.x - 15, _mistakeTextComponent!.position.y + 40),
        anchor: Anchor.topRight,
        textRenderer: scoreTextPaint,
      ),
      _modeTextComponent = TextComponent(
        text: 'Mode ${game.mode == 0 ? 'Easy' : game.mode == 1 ? 'Medium' : 'Hard'}',
        position: Vector2(game.size.x - 15, game.size.y - 15),
        anchor: Anchor.bottomRight,
        textRenderer: modeTextPaint,
      ),
    ]);
  }

  /// Updates the game state every frame.
  @override
  void update(double dt) {
    super.update(dt); // Call the superclass update

    if (!_countdownFinished) {
      countDown -= dt; // Decrease countdown by the time since last frame

      // Update the countdown text component with the current countdown
      if (countDown < 2) {
        _countdownTextComponent?.text = (countDown.toInt() + 1).toString();
      }

      // Check if the countdown has finished
      if (countDown < 0) {
        _countdownFinished = true; // Set countdown finished flag
      }
    } else if (fruitsTime.isEmpty && !hasFruits()) {
      if (_countdownTextComponent != null && !_countdownTextComponent!.isMounted) {
        _countdownTextComponent?.addToParent(this); // Add to parent if not already on screen
      }

      // Update the countdown text component with the current value
      if (level == 10) {
        _countdownTextComponent?.text = (finishCountDown.toInt() + 1).toString(); // Convert to int for display
      } else {
        _countdownTextComponent?.text = "- Level ${level + 1} -";
      }

      // Check if the countdown time has finished
      if (finishCountDown <= 0) {
        gameWin(); // Call the function to indicate a win
      }

      // Decrease the countdown value over time (dt)
      finishCountDown -= dt; // Decrease based on real time

      // Ensure finishCountDown is not negative
      if (finishCountDown < 0) {
        finishCountDown = 0; // Reset to 0 if it has gone below
      }
    } else {
      // Remove the countdown text component once finished
      _countdownTextComponent?.removeFromParent();

      time += dt; // Increment time by the time since last frame

      // Check which fruits should appear based on the current time
      fruitsTime.where((element) => element < time).toList().forEach((element) {
        spawnFruit();
        fruitsTime.remove(element);
      });
    }
  }

  void spawnFruit() {
    final gameSize = game.size;
    double posX = random.nextInt(gameSize.x.toInt()).toDouble();
    Vector2 fruitPosition = Vector2(posX, gameSize.y);
    Vector2 velocity = Vector2(0, game.maxVerticalVelocity);

    final randFruit = game.fruits.random();
    add(
      FruitComponent(
        this,
        fruitPosition,
        acceleration: AppConfig.acceleration,
        fruit: randFruit,
        size: AppConfig.shapeSize,
        image: game.images.fromCache(randFruit.image),
        pageSize: gameSize,
        velocity: velocity,
      ),
    );
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    sliceTrail.addPoint(event.canvasStartPosition);

    componentsAtPoint(event.canvasStartPosition).forEach((element) {
      if (element is FruitComponent) {
        if (element.canDragOnShape) {
          game.isDesktop ? onFruitSliced(sliceTrail) : null;
          element.touchAtPoint(event.canvasStartPosition);
          game.isDesktop ? game.add(FruitSliceComponent(event.canvasStartPosition)) : null;
          game.isDesktop ? playRandomSliceSound() : null;
        }
      }
    });
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    sliceTrail.clear(); // Clear trail on drag end for a fresh swipe
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    _countdownTextComponent?.position = game.size / 2;
    _mistakeTextComponent?.position = Vector2(game.size.x - 15, 10);
    _scoreTextComponent?.position = Vector2(game.size.x - 15, _mistakeTextComponent!.position.y + 40);
    _modeTextComponent?.position = Vector2(game.size.x - 15, game.size.y - 15);
  }

  bool hasFruits() {
    return children.any((component) => component is FruitComponent);
  }

  /// Navigate to the game over screen.
  void gameOver() {
    FlameAudio.bgm.stop();
    game.saveScore(score);
    game.router.pushNamed(AppRouter.gameOver); // Navigate to game over route
  }

  void gameWin() {
    if (level < 10) {
      level++;
      resetLevel();
    } else {
      FlameAudio.bgm.stop();
      game.saveScore(score);
      game.router.pushNamed(AppRouter.gameVictory);
    }
  }

  void resetLevel() {
    fruitsTime.clear();
    time = 0;
    countDown = 3;
    finishCountDown = 2.0;

    _countdownFinished = false;
    generateFruitTimings();
  }

  /// Increment the player's score by one and update the score display.
  void addScore() {
    score++; // Increase score by one
    _scoreTextComponent?.text = 'Score: $score'; // Update score display
  }

  /// Increment the mistake count and update the mistake display.
  void addMistake() {
    mistakeCount++; // Increase mistake count by one
    _mistakeTextComponent?.text = 'Mistake: $mistakeCount'; // Update mistake display
    // Check if the player has made too many mistakes
    if (mistakeCount >= 4) {
      gameOver(); // End the game if mistakes exceed limit
    }
  }

  void onFruitSliced(SliceTrailComponent sliceTrailComponent) {
    sliceTrailComponent.changeColor();
  }

  void playRandomSliceSound() {
    String selectedSound = sliceSounds[random.nextInt(sliceSounds.length)];
    FlameAudio.play(selectedSound, volume: 0.5);
  }

  void generateFruitTimings() {
    fruitsTime.clear();
    double initTime = 0; // Variable to store the initial time for fruit generation

    int fruitCount = getFruitCount(level, game.mode);
    double minInterval = getMinInterval(level, game.mode);

    // Generate timings for when fruits will appear
    for (int i = 0; i < fruitCount; i++) {
      if (i != 0) initTime = fruitsTime.last;

      double milliSecondTime = random.nextInt(100) / 100;
      double componentTime = random.nextInt(1) * minInterval + milliSecondTime + initTime;

      fruitsTime.add(componentTime);
    }
  }

  int getFruitCount(int level, int mode) {
    const List<List<int>> fruitCounts = [
      [10, 15, 20], // Level 1
      [15, 20, 30], // Level 2
      [20, 25, 35], // Level 3
      [25, 30, 40], // Level 4
      [30, 35, 45], // Level 5
      [40, 45, 55], // level 6
      [45, 50, 60], // Level 7
      [55, 60, 70], // Level 8
      [60, 65, 75], // Level 9
      [70, 80, 100] // Level 10
    ];

    return fruitCounts[level - 1][mode];
  }

  double getMinInterval(int level, int mode) {
    const List<List<double>> minIntervals = [
      [2.5, 2.5, 2.2], // Level 1
      [2.3, 2.2, 2.0], //Level 2
      [2.1, 2.0, 1.8], // Level 3
      [1.9, 1.8, 1.6], // Level 4
      [1.7, 1.6, 1.4], // Level 5
      [1.5, 1.4, 1.2], // Level 6
      [1.2, 1.0, 0.8], // Level 7
      [0.8, 0.6, 0.5], // Level 8
      [0.7, 0.5, 0.4], // Level 9
      [0.5, 0.4, 0.3], // Level 10
    ];

    return minIntervals[level - 1][mode];
  }
}
