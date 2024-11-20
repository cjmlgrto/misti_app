import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:misti/common/widgets/button/rounded_button.dart';
import 'package:misti/common/widgets/text/simple_center_text.dart';
import 'package:misti/core/configs/assets/app_images.dart';
import 'package:misti/core/configs/constants/app_router.dart';
import 'package:misti/core/configs/theme/app_colors.dart';
import 'package:misti/game/fruit_cutting_game/main_router_game.dart';
import 'package:misti/presentation/home/widgets/tutorial_fruit_component.dart';

class HomePage extends Component with HasGameReference<MainRouterGame> {
  late final RoundedButton _button;

  late final SimpleCenterText _tutorialRuleLose1Component;
  late final SimpleCenterText _tutorialRuleLose2Component;
  late final SimpleCenterText _tutorialRuleScore1Component;
  late final SimpleCenterText _tutorialRuleScore2Component;

  // ignore: unused_field
  late final TextComponent _ediblesTextComponent;
  late final TextComponent _bombTextComponent;

  @override
  void onLoad() async {
    super.onLoad();

    final textTitlePaint = TextPaint(
      style: const TextStyle(
        fontSize: 26,
        color: AppColors.white,
        fontFamily: 'Insan',
        letterSpacing: 2.0,
        fontWeight: FontWeight.bold,
      ),
    );

    addAll(
      [
        _button = RoundedButton(
          text: 'Start',
          onPressed: () {
            game.router.pushNamed(AppRouter.gamePage);
          },
          bgColor: const Color(0xFF04A1AB), // Updated color
          borderColor: AppColors.white,
        ),
        _ediblesTextComponent = TextComponent(
          text: 'Tap To Kill',
          position: Vector2(45, 10),
          anchor: Anchor.topLeft,
          textRenderer: textTitlePaint,
        ),
        _tutorialRuleLose1Component = SimpleCenterText(
          text: 'Misti Games\n',
          textColor: AppColors.white,
          fontSize: 18,
        ),
        _tutorialRuleLose2Component = SimpleCenterText(
          text: 'Virus Vanquisher',
          textColor: AppColors.white,
          fontSize: 36,
        ),
        _tutorialRuleScore1Component = SimpleCenterText(
          text: 'Protect the kids from harmful bacteria!',
          textColor: AppColors.white,
          fontSize: 16,
        ),
        _tutorialRuleScore2Component = SimpleCenterText(
          text: 'Earn points for each bacteria you eliminate...',
          textColor: AppColors.white,
          fontSize: 16,
        ),
        TutorialFruitsListComponent(
          isLeft: true,
          fruits: [
            TutorialFruitComponent(
                text: 'RSV', imagePath: AppImages.apple, isLeft: true),
            TutorialFruitComponent(
                text: 'Influenza', imagePath: AppImages.banana, isLeft: true),
            TutorialFruitComponent(
                text: 'COVID-19', imagePath: AppImages.cherry, isLeft: true),
            TutorialFruitComponent(
                text: 'Rhinovirus', imagePath: AppImages.kiwi, isLeft: true),
            TutorialFruitComponent(
                text: 'Adenovirus', imagePath: AppImages.orange, isLeft: true),
          ],
        )..position = Vector2(0, 30),
        _bombTextComponent = TextComponent(
          text: "Don't Kill",
          position: Vector2(game.size.x - 45, 10),
          anchor: Anchor.topRight,
          textRenderer: textTitlePaint,
        ),
        TutorialFruitsListComponent(
          isLeft: false,
          fruits: [
            TutorialFruitComponent(
                text: 'Children', imagePath: AppImages.bomb, isLeft: false),
            TutorialFruitComponent(
                text: 'Bubble', imagePath: AppImages.flame, isLeft: false),
            TutorialFruitComponent(
                text: 'Baby', imagePath: AppImages.flutter, isLeft: false),
          ],
        )..position = Vector2(0, 50),
      ],
    );
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    // button in center of page
    _button.position = size / 2;
    _tutorialRuleScore1Component.position =
        Vector2(game.size.x / 2, game.size.y - game.size.y / 3.9);
    _tutorialRuleScore2Component.position =
        Vector2(game.size.x / 2, game.size.y - game.size.y / 5.1);
    _tutorialRuleLose1Component.position =
        Vector2(game.size.x / 2, game.size.y / 5.1);
    _tutorialRuleLose2Component.position =
        Vector2(game.size.x / 2, game.size.y / 3.9);
    _bombTextComponent.position = Vector2(game.size.x - 45, 10);
  }
}
