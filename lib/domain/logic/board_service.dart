import 'package:tetris/domain/entities/values.dart';

class BoardService {
  static void clearLines(
    List<List<Tetromino?>> board,
    int rowLength,
    int colLength,
  ) {
    for (int row = colLength - 1; row >= 0; row--) {
      bool rowIsFull = true;

      for (int col = 0; col < rowLength; col++) {
        if (board[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          for (int c = 0; c < rowLength; c++) {
            board[r][c] = board[r - 1][c];
          }
        }

        for (int c = 0; c < rowLength; c++) {
          board[0][c] = null;
        }

        row++;
      }
    }
  }

  static bool isTopRowOccupied({required List<List<Tetromino?>> board}) {
    for (int col = 0; col < rowLength; col++) {
      if (board[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  static bool checkCollision({
    required List<List<Tetromino?>> board,
    required List<int> piecePosition,
    required Direction direction,
    required int rowLength,
    required int colLength,
  }) {
    for (int i = 0; i < piecePosition.length; i++) {
      int row = (piecePosition[i] / rowLength).floor();
      int col = piecePosition[i] % rowLength;

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

      if (row >= 0 && board[row][col] != null) {
        return true;
      }
    }
    return false;
  }

  static bool boardHasValidPosition(
    List<List<Tetromino?>> board,
    List<int> piecePosition,
    int rowLength,
  ) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      int row = (pos / rowLength).floor();
      int col = pos % rowLength;

      if (row < 0 || col < 0 || row >= board.length || col >= rowLength) {
        return false;
      }

      if (board[row][col] != null) return false;

      if (col == 0) firstColOccupied = true;
      if (col == rowLength - 1) lastColOccupied = true;
    }

    return !(firstColOccupied && lastColOccupied);
  }
}
