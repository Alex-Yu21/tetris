import 'package:flutter/material.dart';

// grid dimensions

final int rowLength = 10;
final int colLength = 15;

enum Direction { left, right, down }

enum Tetromino {
  L,
  /*
  O
  O
  O O
  */
  J,
  /*
    O
    O
  O O
  */
  I,
  /*
  O
  O
  O 
  O
  */
  O,
  /*
  O O
  O O
  */
  S,
  /*
    O O
  O O
  */
  Z,
  /*
  O O
    O O
  */
  T,
  /*
  O
  O O 
  O
  */
}

Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: const Color.fromARGB(255, 129, 116, 78),
  Tetromino.J: const Color.fromARGB(255, 202, 167, 93),
  Tetromino.I: const Color.fromARGB(255, 191, 178, 102),
  Tetromino.O: const Color.fromARGB(255, 205, 145, 89),
  Tetromino.S: const Color.fromARGB(255, 198, 155, 104),
  Tetromino.Z: const Color.fromARGB(255, 133, 122, 55),
  Tetromino.T: const Color.fromARGB(255, 224, 139, 84),
};
