import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final TextEditingController answerController = TextEditingController();
  final FocusNode answerFocusNode = FocusNode();

  // --------------------------------------------------
  // ADD NUMBER
  // --------------------------------------------------

  void addNumber(String number) {
    setState(() {
      answer += number;
      answerController.text = answer;
      answerController.selection = TextSelection.fromPosition(
        TextPosition(offset: answerController.text.length),
      );
    });

    answerFocusNode.requestFocus();
  }
  // --------------------------------------------------
  // DELETE NUMBER
  // --------------------------------------------------

  void deleteNumber() {
    if (answer.isNotEmpty) {
      setState(() {
        answer = answer.substring(0, answer.length - 1);
        answerController.text = answer;

        answerController.selection = TextSelection.fromPosition(
          TextPosition(offset: answerController.text.length),
        );
      });

      answerFocusNode.requestFocus();
    }
  }

  // --------------------------------------------------
  // INITIALIZE
  // --------------------------------------------------

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  // --------------------------------------------------
  // GENERATE QUESTION
  // --------------------------------------------------

  void generateQuestion() {
    number1 = random.nextInt(50) + 1;
    number2 = random.nextInt(50) + 1;

    operation = '+';

    correctAnswer = number1 + number2;

    answer = '';
    answerController.clear();
    isCorrect = null;
    questionStartTime = DateTime.now();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        answerFocusNode.requestFocus();
      }
    });
  }

  // --------------------------------------------------
  // SUBMIT ANSWER
  // --------------------------------------------------

  void submitAnswer() {
    if (answer.isEmpty || questionStartTime == null) {
      return;
    }

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

  // --------------------------------------------------
  // BUILD
  // --------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080B1F),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;
            final double screenHeight = constraints.maxHeight;

            // ------------------------------------------
            // RESPONSIVE BREAKPOINTS
            // ------------------------------------------

            final bool isSmallScreen = screenWidth < 500;
            final bool isMediumScreen = screenWidth >= 500 && screenWidth < 900;

            // ------------------------------------------
            // CONTENT WIDTH
            // ------------------------------------------

            double contentWidth;

            if (isSmallScreen) {
              contentWidth = screenWidth;
            } else if (isMediumScreen) {
              contentWidth = screenWidth * 0.85;
            } else {
              contentWidth = 900;
            }

            // ------------------------------------------
            // RESPONSIVE PADDING
            // ------------------------------------------

            final double horizontalPadding = isSmallScreen
                ? 14
                : isMediumScreen
                ? 24
                : 30;

            final double verticalPadding = isSmallScreen ? 14 : 20;

            // ------------------------------------------
            // QUESTION FONT SIZE
            // ------------------------------------------

            final double questionFontSize = isSmallScreen
                ? 32
                : isMediumScreen
                ? 38
                : 44;

            // ------------------------------------------
            // ANSWER BOX HEIGHT
            // ------------------------------------------

            final double answerBoxHeight = isSmallScreen
                ? 60
                : isMediumScreen
                ? 65
                : 70;

            // ------------------------------------------
            // SPACING
            // ------------------------------------------

            final double topSpacing = isSmallScreen
                ? 25
                : isMediumScreen
                ? 35
                : 45;

            final double questionSpacing = isSmallScreen ? 18 : 25;

            // ------------------------------------------
            // KEYPAD SPACING
            // ------------------------------------------

            final double keypadSpacing = isSmallScreen
                ? 8
                : isMediumScreen
                ? 10
                : 12;

            // ------------------------------------------
            // BUTTON ASPECT RATIO
            // ------------------------------------------

            final double buttonAspectRatio = isSmallScreen
                ? 1.35
                : isMediumScreen
                ? 1.45
                : 1.5;

            return Center(
              child: SizedBox(
                width: contentWidth,
                height: screenHeight,

                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),

                  child: Column(
                    children: [
                      // ==================================
                      // TOP BAR
                      // ==================================

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          // LEVEL
                          const Text(
                            'LEVEL 1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // QUESTION NUMBER
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 11 : 14,
                              vertical: isSmallScreen ? 7 : 8,
                            ),

                            decoration: BoxDecoration(
                              color: const Color(0xFF171B3A),
                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: Text(
                              'Question ${totalQuestions + 1}',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: isSmallScreen ? 12 : 14,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // ==================================
                      // QUESTION TOP SPACE
                      // ==================================
                      SizedBox(height: topSpacing),

                      // ==================================
                      // QUESTION
                      // ==================================
                      Flexible(
                        flex: 0,

                        child: FittedBox(
                          fit: BoxFit.scaleDown,

                          child: Text(
                            '$number1 $operation $number2',

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: questionFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // ==================================
                      // QUESTION → ANSWER SPACE
                      // ==================================
                      SizedBox(height: questionSpacing),

                      // ==================================
                      // ANSWER BOX
                      // ==================================
                      Container(
                        width: double.infinity,
                        height: answerBoxHeight,

                        alignment: Alignment.center,

                        decoration: BoxDecoration(
                          // GREEN WHEN CORRECT
                          color: isCorrect == true
                              ? Colors.green.withValues(alpha: 0.18)
                              // RED WHEN WRONG
                              : isCorrect == false
                              ? Colors.red.withValues(alpha: 0.18)
                              // NORMAL
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

                        child: TextField(
                          controller: answerController,
                          focusNode: answerFocusNode,

                          autofocus: true,

                          keyboardType: TextInputType.number,

                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isSmallScreen ? 23 : 28,
                            fontWeight: FontWeight.bold,
                          ),

                          decoration: const InputDecoration(
                            hintText: 'Your answer',
                            hintStyle: TextStyle(
                              color: Colors.white38,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                            border: InputBorder.none,
                          ),

                          onChanged: (value) {
                            answer = value;
                          },

                          onSubmitted: (_) {
                            submitAnswer();
                          },
                        ),
                      ),

                      // ==================================
                      // ANSWER → KEYPAD SPACE
                      // ==================================
                      SizedBox(height: isSmallScreen ? 14 : 25),

                      // ==================================
                      // KEYPAD
                      // ==================================
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 3,

                          mainAxisSpacing: keypadSpacing,

                          crossAxisSpacing: keypadSpacing,

                          childAspectRatio: buttonAspectRatio,

                          physics: const NeverScrollableScrollPhysics(),

                          children: [
                            // ROW 1
                            numberButton('1'),
                            numberButton('2'),
                            numberButton('3'),

                            // ROW 2
                            numberButton('4'),
                            numberButton('5'),
                            numberButton('6'),

                            // ROW 3
                            numberButton('7'),
                            numberButton('8'),
                            numberButton('9'),

                            // ROW 4
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
          },
        ),
      ),
    );
  }

  // --------------------------------------------------
  // NUMBER BUTTON
  // --------------------------------------------------

  Widget numberButton(String number) {
    return ElevatedButton(
      onPressed: () => addNumber(number),

      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF171B3A),
        foregroundColor: Colors.white,
        elevation: 0,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),

      child: FittedBox(
        fit: BoxFit.scaleDown,

        child: Text(
          number,

          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // ACTION BUTTON
  // --------------------------------------------------

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

      child: FittedBox(
        fit: BoxFit.scaleDown,

        child: Text(
          text,

          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void dispose() {
    answerController.dispose();
    answerFocusNode.dispose();
    super.dispose();
  }
}
