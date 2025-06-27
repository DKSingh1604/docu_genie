import 'package:flutter/material.dart';

class Tipsandguide extends StatelessWidget {
  const Tipsandguide({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Tips and Guide',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Color(0xFF0A0E21),
    );
  }
}
