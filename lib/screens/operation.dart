import 'package:flutter/material.dart';

import 'game.dart';
import 'progress.dart';

class OperationScreen extends StatelessWidget {
  const OperationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080B1F),

      appBar: AppBar(
        backgroundColor: const Color(0xFF080B1F),
        title: const Text(
          'Choose Operation',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;

            final padding = screenWidth < 500 ? 12.0 : 20.0;
            final spacing = screenWidth < 500 ? 10.0 : 15.0;

            // Available width for one card
            final cardWidth = (screenWidth - (padding * 2) - spacing) / 2;

            // Available height for one card
            final cardHeight = (screenHeight - (padding * 2) - spacing) / 2;

            // Automatically adjust card shape to screen
            final cardAspectRatio = cardWidth / cardHeight;

            return Padding(
              padding: EdgeInsets.all(padding),

              child: GridView.count(
                crossAxisCount: 2,

                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,

                childAspectRatio: cardAspectRatio,

                physics: const NeverScrollableScrollPhysics(),

                children: [
                  operationButton(
                    context,
                    '➕\nAddition',
                    gameProgress.additionUnlocked,
                    '+',
                    screenWidth,
                  ),

                  operationButton(
                    context,
                    '➖\nSubtraction',
                    gameProgress.subtractionUnlocked,
                    '-',
                    screenWidth,
                  ),

                  operationButton(
                    context,
                    '✖\nMultiplication',
                    gameProgress.multiplicationUnlocked,
                    '*',
                    screenWidth,
                  ),

                  operationButton(
                    context,
                    '➗\nDivision',
                    gameProgress.divisionUnlocked,
                    '/',
                    screenWidth,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget operationButton(
    BuildContext context,
    String title,
    bool unlocked,
    String operation,
    double screenWidth,
  ) {
    final fontSize = screenWidth < 500
        ? 20.0
        : screenWidth < 900
        ? 25.0
        : 30.0;

    return ElevatedButton(
      onPressed: unlocked
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GameScreen()),
              );
            }
          : null,

      style: ElevatedButton.styleFrom(
        backgroundColor: unlocked
            ? const Color(0xFF171B3A)
            : const Color(0xFF101329),

        foregroundColor: Colors.white,
        disabledForegroundColor: Colors.white38,

        elevation: 0,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth < 500 ? 16 : 20),
        ),
      ),

      child: FittedBox(
        fit: BoxFit.scaleDown,

        child: Text(
          unlocked ? title : '🔒\n$title',
          textAlign: TextAlign.center,

          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
