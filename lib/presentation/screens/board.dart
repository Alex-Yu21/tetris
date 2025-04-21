import 'package:flutter/material.dart';
import 'package:tetris/domain/logic/game_manager.dart';
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
          IconButton(onPressed: () {}, icon: Icon(Icons.pause)),
        ],
      ),
    );
  }

  Row _buildControlsButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: widget.manager.moveLeft,
          icon: Icon(Icons.arrow_circle_left_outlined),
        ),
        IconButton(
          onPressed: widget.manager.rotatePiece,
          icon: Icon(Icons.refresh_rounded),
        ),
        IconButton(
          onPressed: widget.manager.moveRight,
          icon: Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );
  }
}
