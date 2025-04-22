import 'dart:async';
import 'dart:math';
import 'package:tetris/domain/entities/piece.dart';
import 'package:tetris/domain/entities/values.dart';

class GameManager {
  List<List<Tetromino?>> gameBoard = List.generate(
    colLength,
    (i) => List.generate(rowLength, (i) => null),
  );

  Piece currentPiece = Piece(type: Tetromino.L);
  Piece? nextPiece;

  void startGame() {
    currentPiece.initializePiece();
    nextPiece = _generateRandomPiece();

    Duration frameRate = const Duration(milliseconds: 800);
    gameLoop(frameRate);
  }

  void Function()? onTick;

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      if (checkCollision(Direction.down)) {
        chekLanding();
      } else {
        currentPiece.movePiece(Direction.down);
      }
      onTick?.call();
    });
  }

  void rotatePiece() {
    currentPiece.rotatePiece();
  }

  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= colLength || col < 0 || col >= rowLength) {
        return true;
      }

      if (row >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }
    return false;
  }

  void chekLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  void createNewPiece() {
    currentPiece = nextPiece!;
    currentPiece.initializePiece();
    nextPiece = _generateRandomPiece();
  }

  Piece _generateRandomPiece() {
    final rand = Random();
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    return Piece(type: randomType);
  }

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      currentPiece.movePiece(Direction.right);
    }
  }

  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      currentPiece.movePiece(Direction.left);
    }
  }
}
