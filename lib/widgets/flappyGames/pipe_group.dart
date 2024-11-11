import 'dart:math';
import 'package:misti/game/flappyBirdGame/configurations.dart';
import 'package:misti/game/flappyBirdGame/flappy_bird_game.dart';
import 'package:misti/game/flappyBirdGame/obstacles.dart';
import 'package:misti/widgets/flappyGames/pipe.dart';
import 'package:flame/components.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();

  final _random = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    final spacing = 100 + _random.nextDouble() * (heightMinusGround / 4);

    final centerY = spacing + _random.nextDouble() * (heightMinusGround - spacing);

    addAll([
      Pipe(pipePosition: PipePosition.up, height: centerY - spacing / 2), // Top pipe
      Pipe(pipePosition: PipePosition.bottom, height: heightMinusGround - (centerY + spacing / 2)), // Bottom pipe
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt; // Move the pipes to the left

    if (position.x < -10) {
      removeFromParent();
      updateScore();

    }

    if(game.isHit){
      removeFromParent();
      gameRef.isHit=false;

    }
  }

  void updateScore(){
    gameRef.bird.score+=1;

  }
}
