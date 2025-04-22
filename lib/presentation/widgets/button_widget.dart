import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final String normalImage;
  final String pressedImage;
  final VoidCallback onTap;
  final double size;

  const ButtonWidget({
    super.key,
    required this.normalImage,
    required this.pressedImage,
    required this.onTap,
    this.size = 60,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool isPressed = false;

  void _tap(_) {
    setState(() {
      isPressed = true;
    });
  }

  void _unTap(_) {
    setState(() {
      isPressed = false;
    });
  }

  void _cancelTap() {
    setState(() {
      isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTapDown: _tap,
      onTapUp: _unTap,
      onTapCancel: _cancelTap,
      child: Transform.scale(
        scale: 3,
        child: Image.asset(
          isPressed ? widget.pressedImage : widget.normalImage,
          width: widget.size,
          height: widget.size,
        ),
      ),
    );
  }
}
