import 'dart:async';
import 'package:tetris/domain/logic/game_manager.dart';
import 'package:tetris/domain/entities/values.dart';

class GameLoop {
  final GameManager manager;
  Timer? _timer;

  GameLoop(this.manager);

  void start(Duration frameRate) {
    _timer?.cancel();
    _timer = Timer.periodic(frameRate, (timer) {
      if (manager.isPaused) return;

      if (manager.checkCollision(Direction.down)) {
        manager.checkLanding();
      } else {
        manager.currentPiece.movePiece(Direction.down);
      }

      manager.onTick?.call();

      if (manager.gameOver) {
        timer.cancel();
        manager.onGameOver?.call();
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }
}
