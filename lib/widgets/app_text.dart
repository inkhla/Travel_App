import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  double size;
  double space;
  final String text;
  final Color color;

  AppText({
    Key? key,
    required this.text,
    this.color = Colors.black54,
    this.size = 16,
    this.space = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        letterSpacing: space,
      ),
    );
  }
}
