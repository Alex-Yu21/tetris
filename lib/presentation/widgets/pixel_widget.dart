import 'package:flutter/material.dart';

class PixelWidget extends StatelessWidget {
  const PixelWidget({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: EdgeInsets.all(1),
    );
  }
}
