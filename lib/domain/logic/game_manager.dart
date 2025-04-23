import 'dart:math';
import 'package:tetris/domain/entities/piece.dart';
import 'package:tetris/domain/entities/values.dart';
import 'package:tetris/domain/logic/board_service.dart';
import 'package:tetris/domain/logic/game_loop.dart';
import 'package:tetris/domain/logic/rotate_piece_usecase.dart';

class GameManager {
  List<List<Tetromino?>> gameBoard = List.generate(
    colLength,
    (i) => List.generate(rowLength, (i) => null),
  );

  Piece currentPiece = Piece(type: Tetromino.O);
  Piece? nextPiece;
  int currentScore = 0;
  bool gameOver = false;
  bool isPaused = false;

  void Function()? onTick;
  void Function()? onGameOver;

  void _setCurrentPiece(Piece piece) {
    currentPiece = piece;
    currentPiece.initializePiece();
  }

  void _generateNextPiece() {
    nextPiece = _generateRandomPiece();
  }

  // TODO: rotation near border

  GameLoop? _loop;

  void reStartGame() {
    gameBoard = List.generate(
      colLength,
      (i) => List.generate(rowLength, (i) => null),
    );
    currentScore = 0;
    gameOver = false;
    isPaused = false;
    currentPiece = _generateRandomPiece();
    currentPiece.initializePiece();
    nextPiece = _generateRandomPiece();
    _loop ??= GameLoop(this);
    _loop!.start(const Duration(milliseconds: 800));
  }

  void startGame() {
    _setCurrentPiece(_generateRandomPiece());
    _generateNextPiece();
    _loop = GameLoop(this);
    _loop!.start(const Duration(milliseconds: 800));
  }

  bool isTopRowOccupied() {
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
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

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      BoardService.clearLines(gameBoard, rowLength, colLength);
      createNewPiece();
    }
  }

  void createNewPiece() {
    _setCurrentPiece(nextPiece!);
    _generateNextPiece();
    if (isTopRowOccupied()) {
      gameOver = true;
    }
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

  void rotatePiece() {
    RotatePieceUseCase(
      board: gameBoard,
      rowLength: rowLength,
    ).execute(currentPiece);
  }
}
