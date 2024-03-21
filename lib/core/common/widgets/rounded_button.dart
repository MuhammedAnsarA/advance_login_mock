import 'package:advance_login_mock/core/res/colours.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.icon,
    required this.onPressed,
    this.buttonColour,
    this.labelColour,
    super.key,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color? buttonColour;
  final Color? labelColour;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColour ?? Colours.primaryColour,
        foregroundColor: labelColour ?? Colors.white,
        minimumSize: const Size(50, 50),
      ),
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
