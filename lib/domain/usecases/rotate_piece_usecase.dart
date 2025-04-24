import 'package:tetris/domain/entities/piece.dart';
import 'package:tetris/domain/logic/board_service.dart';
import 'package:tetris/domain/logic/rotation_service.dart';

class RotatePieceUseCase {
  final List<List<String?>> board;
  final int rowLength;

  RotatePieceUseCase({required this.board, required this.rowLength});

  void execute(Piece piece) {
    final newRotationState = (piece.rotationState + 1) % 4;

    final newPosition = RotationService.getRotationPosition(
      piece.type,
      piece.position,
      piece.rotationState,
      rowLength,
    );

    if (BoardService.boardHasValidPosition(board, newPosition, rowLength)) {
      piece.position = newPosition;
      piece.rotationState = newRotationState;
      return;
    }

    final movedLeft = newPosition.map((p) => p - 1).toList();
    if (BoardService.boardHasValidPosition(board, movedLeft, rowLength)) {
      piece.position = movedLeft;
      piece.rotationState = newRotationState;
      return;
    }

    final movedRight = newPosition.map((p) => p + 1).toList();
    if (BoardService.boardHasValidPosition(board, movedRight, rowLength)) {
      piece.position = movedRight;
      piece.rotationState = newRotationState;
      return;
    }
  }
}
