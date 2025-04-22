import 'package:flutter/material.dart';
import 'package:tetris/domain/logic/game_manager.dart';
import 'package:tetris/presentation/widgets/button_icon_widget.dart';
import 'package:tetris/presentation/widgets/button_widget.dart';
import 'package:tetris/presentation/widgets/card_widget.dart';
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
    widget.manager.startGame();
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
            Card(
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
                    if (widget.manager.currentPiece.position.contains(index)) {
                      return PixelWidget(
                        color: widget.manager.currentPiece.color,
                        child: index,
                      );
                    } else if (widget.manager.gameBoard[row][col] != null) {
                      final Tetromino? tetrominoType =
                          widget.manager.gameBoard[row][col];

                      return PixelWidget(
                        color: tetrominoColors[tetrominoType]!,
                        child: 1,
                      );
                    } else {
                      return PixelWidget(
                        color: const Color.fromARGB(255, 244, 222, 185),
                        child: index,
                      );
                    }
                  },
                ),
              ),
            ),
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
          const CardWidget(title: 'SCORE:', result: Text('data')),
          const CardWidget(title: 'NEXT:', result: Icon(Icons.outbox_outlined)),
          ButtonIconWidget(
            normalImage: 'assets/button.png',
            pressedImage: 'assets/button_pr.png',
            onTap: () {},
            icon: Icon(Icons.pause),
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
          normalImage: 'assets/arrow_left.png',
          onTap: widget.manager.moveLeft,
          pressedImage: 'assets/arrow_left_pr.png',
        ),
        ButtonIconWidget(
          icon: Icon(Icons.refresh_rounded),
          normalImage: 'assets/button_circle.png',
          pressedImage: 'assets/button_circle_pr.png',
          onTap: widget.manager.rotatePiece,
        ),
        ButtonWidget(
          normalImage: 'assets/arrow_right.png',
          onTap: widget.manager.moveRight,
          pressedImage: 'assets/arrow_right_pr.png',
        ),
      ],
    );
  }
}
