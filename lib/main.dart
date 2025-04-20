import 'package:flutter/material.dart';
import 'package:tetris/board.dart';

void main() {
  runApp(TetrisGame());
}

class TetrisGame extends StatelessWidget {
  const TetrisGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: BoardScreen());
  }
}
