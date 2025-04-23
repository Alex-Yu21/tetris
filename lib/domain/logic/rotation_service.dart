import 'package:tetris/domain/entities/values.dart';

class RotationService {
  static List<int> getRotationPosition(
    Tetromino type,
    List<int> pos,
    int rotationState,
    int rowLength,
  ) {
    List<int> newPosition = [];

    switch (type) {
      case Tetromino.L:
        switch (rotationState % 4) {
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
        switch (rotationState % 4) {
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
        switch (rotationState % 2) {
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
        switch (rotationState % 2) {
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
        switch (rotationState % 2) {
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
        switch (rotationState % 4) {
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

    return newPosition;
  }
}
