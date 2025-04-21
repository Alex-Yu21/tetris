import 'package:flutter/material.dart';

class PixelWidget extends StatelessWidget {
  const PixelWidget({super.key, required this.color, required this.child});
  final Color color;
  final int child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: EdgeInsets.all(1),
      child: Center(
        child: Text(child.toString(), style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
