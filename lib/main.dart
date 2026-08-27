import 'package:flutter/material.dart';
import 'screens/welcome.dart';

void main() {
  runApp(const PersonalisedMathGame());
}

class PersonalisedMathGame extends StatelessWidget {
  const PersonalisedMathGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personalised Math Game',
      home: const WelcomeScreen(),
    );
  }
}