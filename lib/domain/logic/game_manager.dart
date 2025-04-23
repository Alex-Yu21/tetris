import 'dart:math';
import 'package:tetris/domain/entities/piece.dart';
import 'package:tetris/domain/entities/values.dart';
import 'package:tetris/domain/logic/game_loop.dart';

class GameManager {
  List<List<Tetromino?>> gameBoard = List.generate(
    colLength,
    (i) => List.generate(rowLength, (i) => null),
  );

  Piece currentPiece = Piece(type: Tetromino.Z);
  Piece? nextPiece;
  int currentScore = 0;
  bool gameOver = false;
  bool isPaused = false;
  void Function()? onTick;
  void Function()? onGameOver;

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
    currentPiece.initializePiece();
    nextPiece = _generateRandomPiece();
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
      clearLines();
      createNewPiece();
    }
  }

  void createNewPiece() {
    currentPiece = nextPiece!;
    currentPiece.initializePiece();
    nextPiece = _generateRandomPiece();
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

  void clearLines() {
    for (int row = colLength - 1; row >= 0; row--) {
      bool rowIsFull = true;
      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        gameBoard[0] = List.generate(rowLength, (index) => null);
        currentScore++;
        row++;
      }
    }
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

  bool positionIsValid(position) {
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      if (!positionIsValid(pos)) {
        return false;
      }

      int col = pos % rowLength;
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }
    return !(firstColOccupied && lastColOccupied);
  }

  void rotatePiece() {
    List<int> newPosition = [];
    final pos = currentPiece.position;
    final type = currentPiece.type;

    switch (type) {
      case Tetromino.L:
        switch (currentPiece.rotationState % 4) {
          case 0:
            newPosition = [
              pos[1] - rowLength,
              pos[1],
              pos[1] + rowLength,
              pos[1] + rowLength + 1,
            ];
            break;
          case 1:
            newPosition = [
              pos[1] - 1,
              pos[1],
              pos[1] + 1,
              pos[1] + rowLength - 1,
            ];
            break;
          case 2:
            newPosition = [
              pos[1] + rowLength,
              pos[1],
              pos[1] - rowLength,
              pos[1] - rowLength - 1,
            ];
            break;
          case 3:
            newPosition = [
              pos[1] - rowLength + 1,
              pos[1],
              pos[1] + 1,
              pos[1] - 1,
            ];
            break;
        }
        break;

      case Tetromino.J:
        switch (currentPiece.rotationState % 4) {
          case 0:
            newPosition = [
              pos[1] - rowLength,
              pos[1],
              pos[1] + rowLength,
              pos[1] + rowLength - 1,
            ];
            break;
          case 1:
            newPosition = [
              pos[1] - 1,
              pos[1],
              pos[1] + 1,
              pos[1] - rowLength - 1,
            ];
            break;
          case 2:
            newPosition = [
              pos[1] + rowLength,
              pos[1],
              pos[1] - rowLength,
              pos[1] - rowLength + 1,
            ];
            break;
          case 3:
            newPosition = [
              pos[1] + 1,
              pos[1],
              pos[1] - 1,
              pos[1] + rowLength + 1,
            ];
            break;
        }
        break;

      case Tetromino.I:
        switch (currentPiece.rotationState % 2) {
          case 0:
            newPosition = [
              pos[1] - rowLength,
              pos[1],
              pos[1] + rowLength,
              pos[1] + 2 * rowLength,
            ];
            break;
          case 1:
            newPosition = [pos[1] - 1, pos[1], pos[1] + 1, pos[1] + 2];
            break;
        }
        break;

      case Tetromino.O:
        newPosition = List.from(pos);
        break;

      case Tetromino.Z:
        switch (currentPiece.rotationState % 2) {
          case 0:
            newPosition = [
              pos[1] - rowLength,
              pos[1],
              pos[1] - 1,
              pos[1] + rowLength - 1,
            ];
            break;
          case 1:
            newPosition = [
              pos[1] - 1,
              pos[1],
              pos[1] + rowLength,
              pos[1] + rowLength + 1,
            ];
            break;
        }
        break;

      case Tetromino.S:
        switch (currentPiece.rotationState % 2) {
          case 0:
            newPosition = [
              pos[1] - rowLength,
              pos[1],
              pos[1] + 1,
              pos[1] + rowLength + 1,
            ];
            break;
          case 1:
            newPosition = [
              pos[1] + 1,
              pos[1],
              pos[1] + rowLength,
              pos[1] + rowLength - 1,
            ];
            break;
        }
        break;

      case Tetromino.T:
        switch (currentPiece.rotationState % 4) {
          case 0:
            newPosition = [
              pos[1] - rowLength,
              pos[1],
              pos[1] + 1,
              pos[1] + rowLength,
            ];
            break;
          case 1:
            newPosition = [pos[1] - 1, pos[1], pos[1] + 1, pos[1] - rowLength];
            break;
          case 2:
            newPosition = [
              pos[1] - rowLength,
              pos[1],
              pos[1] + rowLength,
              pos[1] - 1,
            ];
            break;
          case 3:
            newPosition = [pos[1] + 1, pos[1], pos[1] - 1, pos[1] + rowLength];
            break;
        }
        break;
    }

    if (piecePositionIsValid(newPosition)) {
      currentPiece.position = newPosition;
      currentPiece.rotationState = (currentPiece.rotationState + 1) % 4;
    }
  }
}
