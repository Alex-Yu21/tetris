import 'package:flutter/material.dart';
import 'package:tetris/presentation/widgets/button_icon_widget.dart';
import 'package:tetris/presentation/widgets/button_widget.dart';

class PauseDialog extends StatelessWidget {
  const PauseDialog({
    super.key,
    required this.isGameOver,
    required this.onContinue,
    required this.onRestart,
    required this.score,
  });

  final bool isGameOver;
  final VoidCallback onContinue;
  final VoidCallback onRestart;
  final int score;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFFFF5DD),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF744E2E), width: 2),
      ),
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonWidget(
                  normalImage: 'assets/buttons/close.png',
                  onTap: () {
                    onContinue();
                  },
                  pressedImage: 'assets/buttons/close_pr.png',
                  scale: 2,
                ),
              ],
            ),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isGameOver
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.scale(
                            scale: 3.5,
                            child: Image.asset('assets/icons/dead.png'),
                          ),
                          SizedBox(width: 18),
                          Text(
                            'GAME OVER',
                            style: const TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF744E2E),
                            ),
                          ),
                        ],
                      )
                      : Text(
                        'PAUSE',
                        style: const TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF744E2E),
                        ),
                      ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SCORE: $score',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xFF744E2E),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Transform.scale(
                        scale: 3,
                        child: Image.asset('assets/icons/coin.png'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  if (isGameOver)
                    IntrinsicWidth(
                      child: ButtonIconWidget(
                        normalImage: 'assets/buttons/button_long.png',
                        pressedImage: 'assets/buttons/button_long_pr.png',
                        onTap: () {
                          onRestart();
                        },
                        icon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'RESTART',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF744E2E),
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.replay, color: Color(0xFF744E2E)),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IntrinsicWidth(
                          child: ButtonIconWidget(
                            normalImage: 'assets/buttons/button_long.png',
                            pressedImage: 'assets/buttons/button_long_pr.png',

                            onTap: onContinue,
                            icon: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  SizedBox(width: 8),
                                  Text(
                                    'PLAY',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF744E2E),
                                    ),
                                  ),
                                  SizedBox(width: 40),
                                  Icon(
                                    Icons.play_arrow,
                                    color: Color(0xFF744E2E),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ButtonIconWidget(
                          icon: const Icon(
                            Icons.refresh_rounded,
                            color: Color(0xFF744E2E),
                          ),
                          normalImage: 'assets/buttons/button_circle.png',
                          pressedImage: 'assets/buttons/button_circle_pr.png',
                          onTap: () {
                            onRestart();
                          },
                        ),
                      ],
                    ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
