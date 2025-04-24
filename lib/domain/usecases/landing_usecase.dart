import 'package:tetris/domain/entities/piece.dart';
import 'package:tetris/domain/entities/values.dart';
import 'package:tetris/domain/logic/board_service.dart';

class LandingUseCase {
  final List<List<String?>> board;
  final int rowLength;
  final int colLength;
  final void Function() createNewPiece;

  LandingUseCase({
    required this.board,
    required this.rowLength,
    required this.colLength,
    required this.createNewPiece,
  });

  void execute(Piece piece, Map<String, Piece> allPieces, String? pieceId) {
    final isColliding = BoardService.checkCollision(
      board: board,
      piecePosition: piece.position,
      direction: Direction.down,
      rowLength: rowLength,
      colLength: colLength,
    );

    if (isColliding) {
      for (final pos in piece.position) {
        final row = (pos / rowLength).floor();
        final col = pos % rowLength;
        if (row >= 0 && col >= 0) {
          board[row][col] = pieceId;
        }
      }

      BoardService.clearLines(board, rowLength, colLength, allPieces);

      createNewPiece();
    }
  }
}
