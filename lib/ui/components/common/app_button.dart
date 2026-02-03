import 'package:flutter/material.dart';
import 'package:tictactoe/env/themes/basic_theme.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const AppButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(context.appTheme.radius.x),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(context.appTheme.radius.x),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(context.appTheme.radius.x),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.appTheme.horizontalPadding,
            vertical: context.appTheme.horizontalPadding / 2,
          ),
          child: Text(text, style: context.appTheme.buttonTextStyle),
        ),
      ),
    );
  }
}
