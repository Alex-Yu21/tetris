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
  Tetromino.L: const Color.fromARGB(255, 199, 175, 255),
  Tetromino.J: const Color.fromARGB(255, 223, 164, 161),
  Tetromino.I: const Color.fromARGB(255, 194, 123, 131),
  Tetromino.O: const Color.fromARGB(255, 136, 161, 111),
  Tetromino.S: const Color.fromARGB(255, 106, 144, 107),
  Tetromino.Z: const Color.fromARGB(255, 146, 178, 212),
  Tetromino.T: const Color.fromARGB(255, 180, 203, 221),
};
