import 'package:flutter/material.dart';

import 'dart:math';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String answer = '';
  bool? isCorrect;

  DateTime? questionStartTime;
  double calculationTime = 0;

  int totalQuestions = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  double accuracy = 0;
  final int questionsPerLevel = 10;

  int number1 = 1;
  int number2 = 9;
  String operation = '+';

  int correctAnswer = 10;

  final Random random = Random();

  void addNumber(String number) {
    setState(() {
      answer += number;
    });
  }

  void deleteNumber() {
    if (answer.isNotEmpty) {
      setState(() {
        answer = answer.substring(0, answer.length - 1);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    number1 = random.nextInt(50) + 1;
    number2 = random.nextInt(50) + 1;

    operation = '+';

    correctAnswer = number1 + number2;

    answer = '';
    isCorrect = null;
    questionStartTime = DateTime.now();
  }

  void submitAnswer() {
    if (answer.isEmpty || questionStartTime == null) return;

    final userAnswer = int.tryParse(answer);

    final endTime = DateTime.now();

    calculationTime =
        endTime.difference(questionStartTime!).inMilliseconds / 1000;

    setState(() {
      isCorrect = userAnswer == correctAnswer;

      totalQuestions++;

      if (isCorrect == true) {
        correctAnswers++;
      } else {
        wrongAnswers++;
      }

      accuracy = (correctAnswers / totalQuestions) * 100;
      if (totalQuestions == questionsPerLevel) {
        debugPrint('--- LEVEL COMPLETE ---');
        debugPrint('Correct: $correctAnswers / $totalQuestions');
        debugPrint('Accuracy: ${accuracy.toStringAsFixed(1)}%');
      }
    });
    debugPrint(
      'Answer: $userAnswer | '
      'Correct: $isCorrect | '
      'Time: ${calculationTime.toStringAsFixed(2)} seconds | '
      'Accuracy: ${accuracy.toStringAsFixed(1)}%',
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;

      setState(() {
        generateQuestion();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080B1F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'LEVEL 1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF171B3A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Question 1',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 45),

              // Question
              Text(
                '$number1 $operation $number2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // Answer box
              Container(
                width: double.infinity,
                height: 70,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isCorrect == true
                      ? Colors.green.withValues(alpha: 0.18)
                      : isCorrect == false
                      ? Colors.red.withValues(alpha: 0.18)
                      : const Color(0xFF151936),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isCorrect == true
                        ? Colors.green
                        : isCorrect == false
                        ? Colors.red
                        : const Color(0xFF6845D8),
                    width: 2,
                  ),
                ),
                child: Text(
                  answer.isEmpty ? 'Your answer' : answer,
                  style: TextStyle(
                    color: answer.isEmpty ? Colors.white38 : Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Number keypad
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.5,
                  children: [
                    numberButton('1'),
                    numberButton('2'),
                    numberButton('3'),
                    numberButton('4'),
                    numberButton('5'),
                    numberButton('6'),
                    numberButton('7'),
                    numberButton('8'),
                    numberButton('9'),
                    actionButton('⌫', deleteNumber),
                    numberButton('0'),
                    actionButton('✓', submitAnswer, special: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget numberButton(String number) {
    return ElevatedButton(
      onPressed: () => addNumber(number),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF171B3A),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      child: Text(
        number,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget actionButton(
    String text,
    VoidCallback onPressed, {
    bool special = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: special
            ? const Color(0xFF6C4AB6)
            : const Color(0xFF252A4A),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }
}
