import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class InRinging extends StatelessWidget {
  const InRinging({super.key, required this.title1, required this.title2});

  final String title1;

  final String title2;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 16.0,
          fontFamily: 'Agne',
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TypewriterAnimatedText(title1, textAlign: TextAlign.center),
            TypewriterAnimatedText(title2, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
