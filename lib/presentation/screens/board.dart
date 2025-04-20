import 'package:flutter/material.dart';
import 'package:tetris/presentation/widgets/card_widget.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardState();
}

class _BoardState extends State<BoardScreen> {
  // grid dimensions
  final int rowLength = 10;
  final int colLength = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CardWidget(title: 'SCORE:', result: Text('data')),
                  const CardWidget(
                    title: 'NEXT:',
                    result: Icon(Icons.outbox_outlined),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.pause,
                      size: Theme.of(context).iconTheme.size,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ],
              ),
            ),
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
                  itemBuilder:
                      (context, index) => Center(
                        child: Text(
                          index.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_circle_left_outlined),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.refresh_rounded)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_circle_right_outlined),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
