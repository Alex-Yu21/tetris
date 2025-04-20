import 'package:flutter/material.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardState();
}

class _BoardState extends State<BoardScreen> {
  // grid dimensions
  int rowLength = 10;
  int colLength = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 232),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      color: const Color.fromARGB(255, 255, 245, 221),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Color.fromARGB(255, 116, 78, 46),
                          width: 3,
                        ),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text(
                        'score:',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 116, 78, 46),
                        ),
                      ),
                    ),
                    Card(
                      color: const Color.fromARGB(255, 255, 245, 221),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Color.fromARGB(255, 116, 78, 46),
                          width: 3,
                        ),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text(
                        'next:',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 116, 78, 46),
                        ),
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.pause)),
                  ],
                ),
                Card(
                  color: const Color.fromARGB(255, 255, 245, 221),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 116, 78, 46),
                      width: 3,
                    ),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: rowLength * colLength,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: rowLength,
                      ),
                      itemBuilder:
                          (context, index) => Center(
                            child: Text(
                              index.toString(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 116, 78, 46),
                              ),
                            ),
                          ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.arrow_circle_left_outlined,
                        size: 60,
                        color: Color.fromARGB(255, 116, 78, 46),
                      ),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.refresh_rounded,
                        size: 60,
                        color: Color.fromARGB(255, 116, 78, 46),
                      ),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 60,
                        color: Color.fromARGB(255, 116, 78, 46),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}
