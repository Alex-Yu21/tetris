import 'package:tetris/domain/entities/values.dart';

class Piece {
  Piece({required this.type});
  Tetromino type;
  List<int> position = [];

  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [4, 14, 24, 25];
      case Tetromino.G:
        position = [5, 15, 25, 24];
      case Tetromino.I:
        position = [4, 14, 24, 34];
      case Tetromino.O:
        position = [4, 14, 5, 15];
      case Tetromino.S:
        position = [0, 0, 0, 0];
      case Tetromino.Z:
        position = [0, 0, 0, 0];
      case Tetromino.T:
        position = [0, 0, 0, 0];
        break;
      default:
    }
  }
}
