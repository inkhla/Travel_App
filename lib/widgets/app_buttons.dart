import 'package:flutter/material.dart';
import 'package:travel_app/widgets/app_text.dart';

class AppButtons extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  double size;
  final Color borderColor;
  String? text;
  IconData? icon;
  bool? isIcon;

  AppButtons({
    Key? key,
    required this.size,
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
    this.text = 'hi',
    this.icon,
    this.isIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: 1,
          )),
      child: isIcon == false
          ? Center(
            child: AppText(
                text: text!,
                color: color,
              ),
          )
          : Center(
            child: Icon(
                icon,
                color: color,
              ),
          ),
    );
  }
}
