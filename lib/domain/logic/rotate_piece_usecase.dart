import 'package:tetris/domain/entities/piece.dart';
import 'package:tetris/domain/entities/values.dart';
import 'package:tetris/domain/logic/board_service.dart';
import 'package:tetris/domain/logic/rotation_service.dart';

class RotatePieceUseCase {
  final List<List<Tetromino?>> board;
  final int rowLength;

  RotatePieceUseCase({required this.board, required this.rowLength});

  void execute(Piece piece) {
    final newPosition = RotationService.getRotationPosition(
      piece.type,
      piece.position,
      piece.rotationState,
      rowLength,
    );

    if (BoardService.boardHasValidPosition(board, newPosition, rowLength)) {
      piece.position = newPosition;
      piece.rotationState = (piece.rotationState + 1) % 4;
    }
  }
}
