import 'package:flutter/material.dart';
import 'package:tetris/domain/entities/values.dart';

class Piece {
  Piece({required this.type});

  final Tetromino type;
  List<int> position = [];
  int rotationState = 0;

  Color get color => tetrominoColors[type] ?? Colors.white;

  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [-26, -16, -6, -5];
        break;
      case Tetromino.J:
        position = [-25, -15, -5, -6];
        break;
      case Tetromino.I:
        position = [-4, -5, -6, -7];
        break;
      case Tetromino.O:
        position = [-15, -16, -5, -6];
        break;
      case Tetromino.S:
        position = [-15, -14, -6, -5];
        break;
      case Tetromino.Z:
        position = [-17, -16, -6, -5];
        break;
      case Tetromino.T:
        position = [-26, -16, -6, -15];
        break;
    }
  }

  void movePiece(Direction direction) {
    for (int i = 0; i < position.length; i++) {
      switch (direction) {
        case Direction.down:
          position[i] += rowLength;
          break;
        case Direction.left:
          position[i] -= 1;
          break;
        case Direction.right:
          position[i] += 1;
          break;
      }
    }
  }
}
