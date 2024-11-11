import 'package:flame/components.dart';
import 'package:misti/game/flappyBirdGame/assets.dart';
import 'package:misti/game/flappyBirdGame/flappy_bird_game.dart';

class Background extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  Background();

  @override
  Future<void> onLoad() async {
    //await super.onLoad(); // Call the super method
    final background = await gameRef.images.load(Assets.background); // Use gameRef.images
    size = gameRef.size; // Ensure gameRef.size is set properly
    sprite = Sprite(background); // Set the sprite
  }
}
