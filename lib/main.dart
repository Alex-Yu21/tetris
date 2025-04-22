import 'package:flutter/material.dart';
import 'package:tetris/domain/logic/game_manager.dart';
import 'package:tetris/presentation/screens/board.dart';

void main() {
  runApp(TetrisGame());
}

class TetrisGame extends StatelessWidget {
  const TetrisGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF8E8),
        primaryColor: const Color(0xFF744E2E),
        cardTheme: CardTheme(
          color: const Color(0xFFFFF5DD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFF744E2E), width: 3),
          ),
          elevation: 4,
          margin: const EdgeInsets.symmetric(horizontal: 20),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF744E2E),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(184, 116, 78, 46),
          size: 45,
        ),
        dialogTheme: DialogTheme(
          shadowColor: Color.fromARGB(184, 116, 78, 46),
          backgroundColor: const Color(0xFFFFF8E8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFF744E2E), width: 3),
          ),
          elevation: 4,
        ),
      ),
      home: BoardScreen(manager: GameManager()),
    );
  }
}
