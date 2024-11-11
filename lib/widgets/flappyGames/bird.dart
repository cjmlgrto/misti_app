import 'package:flame/components.dart';
import 'package:misti/game/flappyBirdGame/assets.dart';
import 'package:misti/game/flappyBirdGame/bird_movements.dart';
import 'package:misti/game/flappyBirdGame/configurations.dart';
import 'package:misti/game/flappyBirdGame/flappy_bird_game.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/cupertino.dart';


class Bird extends SpriteGroupComponent<BirdMovement> with HasGameRef<FlappyBirdGame>  ,CollisionCallbacks{
  Bird();

  int score =0;


  @override
  Future<void> onLoad() async {
    //await super.onLoad(); // Ensure you call this

    // Load bird sprite images
    final birdMidFlap = await gameRef.loadSprite(Assets.birdMidFlap);
    final birdUpFlap = await gameRef.loadSprite(Assets.birdUpFlap);
    final birdDownFlap = await gameRef.loadSprite(Assets.birdDownFlap);

    // Set the sprites before accessing current
    sprites = {
      BirdMovement.middle: birdMidFlap,
      BirdMovement.up: birdUpFlap,
      BirdMovement.down: birdDownFlap,
    };

    add(
        CircleHitbox()
    );

    current = BirdMovement.middle;
    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2); // Center the bird vertically



  }

  void fly(){

    add(
      MoveByEffect(
        Vector2(0, Config.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down,
      ),
    );

    current = BirdMovement.up;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    gameOver();

    //debugPrint('Collision Detected');
  }

  void reset(){
    position = Vector2(50, gameRef.size.y/2 - size.y/2);
    score=0;

  }

  void gameOver(){
    game.overlays.add('gameOver');
    gameRef.pauseEngine();
    game.isHit=true;



  }




  @override
  void update(double dt){
    super.update(dt);
    position.y += Config.birdVelocity *dt;

  }
}
