import 'package:flutter/material.dart';

class PauseDialog extends StatelessWidget {
  const PauseDialog({
    super.key,
    required this.isGameOver,
    required this.onContinue,
    required this.score,
  });

  final bool isGameOver;
  final VoidCallback onContinue;
  final int score;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          Text(isGameOver ? 'GAME OVER' : 'PAUSE'),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      actions: [
        Column(
          children: [
            Text('SCORE: $score'),
            TextButton(
              onPressed: onContinue,
              child: isGameOver ? const Text('Restart') : const Text('Play'),
            ),
          ],
        ),
      ],
    );
  }
}
