import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  const BasicAppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height,
  });

  final VoidCallback onPressed;
  final String title;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 80),
        backgroundColor: const Color.fromARGB(255, 47, 204, 8),
      ),
      child: Text(title, style: TextStyle(color: Colors.black, fontSize: 20)),
    );
  }
}
