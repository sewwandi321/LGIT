import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color background;
  final Color textColor;
  final Color border;
  final String text;

  const FollowButton(
      {Key? key,
      required this.background,
      required this.textColor,
      required this.border,
      required this.text,
      this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: background,
            border: Border.all(
              color: border,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 250,
          height: 27,
        ),
      ),
    );
  }
}
