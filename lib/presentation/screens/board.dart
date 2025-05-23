import 'package:flutter/material.dart';
import 'package:tetris/domain/logic/game_manager.dart';
import 'package:tetris/presentation/widgets/button_icon_widget.dart';
import 'package:tetris/presentation/widgets/button_widget.dart';
import 'package:tetris/presentation/widgets/card_widget.dart';
import 'package:tetris/presentation/widgets/pause_dialog.dart';
import 'package:tetris/presentation/widgets/pixel_widget.dart';
import 'package:tetris/domain/entities/values.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key, required this.manager});

  final GameManager manager;

  @override
  State<BoardScreen> createState() => _BoardState();
}

class _BoardState extends State<BoardScreen> {
  @override
  void initState() {
    super.initState();

    widget.manager.onTick = () {
      setState(() {});
    };

    widget.manager.onGameOver = () {
      widget.manager.isPaused = true;
      _pauseDialog(isGameOver: true);
    };

    widget.manager.startGame();
  }

  Future<void> _pauseDialog({required bool isGameOver}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => PauseDialog(
            score: widget.manager.currentScore,
            isGameOver: isGameOver,
            onRestart: () {
              widget.manager.reStartGame();
              setState(() {});
              Navigator.of(context).pop();
            },

            onContinue: () {
              Navigator.pop(context);
              setState(() {
                if (isGameOver) {
                  widget.manager.startGame();
                }
                widget.manager.isPaused = false;
              });
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 10),
            _buildHeader(),
            _buildGrid(),
            _buildControlsButtons(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CardWidget(
            title: 'SCORE:',
            result: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.manager.currentScore.toString()),
                const SizedBox(width: 8),
                Transform.scale(
                  scale: 2.5,
                  child: Image.asset('assets/icons/coin.png'),
                ),
              ],
            ),
          ),
          CardWidget(
            title: 'NEXT:',
            result: Text(
              widget.manager.nextPiece?.type.name.substring(0, 1) ?? '',
            ),
          ),
          ButtonIconWidget(
            normalImage: 'assets/buttons/button.png',
            pressedImage: 'assets/buttons/button_pr.png',
            icon: const Icon(Icons.pause),
            onTap: () {
              setState(() {
                widget.manager.isPaused = true;
              });
              _pauseDialog(isGameOver: false);
            },
          ),
        ],
      ),
    );
  }

  Row _buildControlsButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonWidget(
          normalImage: 'assets/buttons/arrow_left.png',
          onTap: () {
            widget.manager.moveLeft();
            setState(() {});
          },
          pressedImage: 'assets/buttons/arrow_left_pr.png',
        ),
        ButtonIconWidget(
          icon: const Icon(Icons.refresh_rounded),
          normalImage: 'assets/buttons/button_circle.png',
          pressedImage: 'assets/buttons/button_circle_pr.png',
          onTap: () {
            widget.manager.rotatePiece();
            setState(() {});
          },
        ),
        ButtonWidget(
          normalImage: 'assets/buttons/arrow_right.png',
          onTap: () {
            widget.manager.moveRight();
            setState(() {});
          },
          pressedImage: 'assets/buttons/arrow_right_pr.png',
        ),
      ],
    );
  }

  Card _buildGrid() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: rowLength * colLength,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: rowLength,
          ),
          itemBuilder: (context, index) {
            int row = (index / rowLength).floor();
            int col = index % rowLength;
            final String? cellId = widget.manager.gameBoard[row][col];

            if (widget.manager.currentPiece.position.contains(index)) {
              return PixelWidget(color: widget.manager.currentPiece.color);
            } else if (cellId != null &&
                widget.manager.allPieces.containsKey(cellId)) {
              final piece = widget.manager.allPieces[cellId]!;

              return PixelWidget(color: tetrominoColors[piece.type]!);
            } else {
              return const PixelWidget(
                color: Color.fromARGB(255, 253, 239, 205),
              );
            }
          },
        ),
      ),
    );
  }
}
