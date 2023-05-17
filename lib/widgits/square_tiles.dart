import 'package:flutter/material.dart';
import 'package:http/retry.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final VoidCallback handlePress;
  const SquareTile(
      {super.key, required this.imagePath, required this.handlePress});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
      onTap: () => handlePress(),
      child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[200]),
          child: Image.asset(imagePath, height: 60)),
    ));
  }
}
