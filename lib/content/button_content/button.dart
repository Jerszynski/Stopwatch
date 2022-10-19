import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.isButtonDisabled,
  }) : super(key: key);

  final String title;
  final onPressed;
  final bool isButtonDisabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green.shade400,
      ),
      onPressed: isButtonDisabled ? null : onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
