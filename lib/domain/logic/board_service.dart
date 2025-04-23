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
