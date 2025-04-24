import 'package:tetris/domain/entities/piece.dart';
import 'package:tetris/domain/entities/values.dart';
import 'dart:math';

class BoardService {
  static int clearLines(
    List<List<String?>> board,
    int rowLength,
    int colLength,
    Map<String, Piece> allPieces,
  ) {
    bool didClear;
    int linesCleared = 0;

    do {
      didClear = false;
      final touchedIds = <String>{};

      for (int row = colLength - 1; row >= 0; row--) {
        bool full = board[row].every((cell) => cell != null);
        if (!full) continue;

        for (int c = 0; c < rowLength; c++) {
          touchedIds.add(board[row][c]!);
        }

        for (int r = row; r > 0; r--) {
          board[r] = List<String?>.from(board[r - 1]);
        }
        board[0] = List<String?>.filled(rowLength, null);

        didClear = true;
        linesCleared++;
        break;
      }

      if (!didClear) break;

      final remainingIds = allPieces.keys.toList();
      for (final id in remainingIds) {
        if (!board.any((r) => r.contains(id))) {
          allPieces.remove(id);
          continue;
        }

        if (touchedIds.contains(id)) {
          _applyBlockGravity(id, board, rowLength, colLength);
        } else {
          _applyShapeGravity(id, board, rowLength, colLength);
        }
      }
    } while (didClear);
    return linesCleared;
  }

  static void _applyShapeGravity(
    String id,
    List<List<String?>> board,
    int rowLength,
    int colLength,
  ) {
    final blocks = <Point<int>>[];
    for (int r = 0; r < colLength; r++) {
      for (int c = 0; c < rowLength; c++) {
        if (board[r][c] == id) blocks.add(Point(r, c));
      }
    }
    if (blocks.isEmpty) return;

    for (final p in blocks) {
      board[p.x][p.y] = null;
    }

    int maxFall = colLength;
    for (final p in blocks) {
      int dist = 0, nr = p.x + 1;
      while (nr < colLength && board[nr][p.y] == null) {
        dist++;
        nr++;
      }
      maxFall = min(maxFall, dist);
      if (maxFall == 0) break;
    }

    for (final p in blocks) {
      board[p.x + maxFall][p.y] = id;
    }
  }

  static void _applyBlockGravity(
    String id,
    List<List<String?>> board,
    int rowLength,
    int colLength,
  ) {
    bool moved;
    do {
      moved = false;
      for (int r = colLength - 2; r >= 0; r--) {
        for (int c = 0; c < rowLength; c++) {
          if (board[r][c] == id && board[r + 1][c] == null) {
            board[r + 1][c] = id;
            board[r][c] = null;
            moved = true;
          }
        }
      }
    } while (moved);
  }

  static bool isTopRowOccupied({required List<List<String?>> board}) {
    for (int col = 0; col < rowLength; col++) {
      if (board[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  static bool checkCollision({
    required List<List<String?>> board,
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
    List<List<String?>> board,
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

      if (board[row][col] != null) {
        return false;
      }

      if (col == 0) firstColOccupied = true;
      if (col == rowLength - 1) lastColOccupied = true;
    }

    return !(firstColOccupied && lastColOccupied);
  }
}
