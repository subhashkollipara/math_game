import 'package:flutter/material.dart';
import 'game.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF4D6),
              Color(0xFFE8F7FF),
              Color(0xFFF3E8FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Floating math symbols
              const Positioned(
                top: 45,
                left: 28,
                child: _FloatingSymbol(
                  symbol: '+',
                  size: 34,
                  color: Color(0xFFFF8A65),
                  angle: -0.15,
                ),
              ),

              const Positioned(
                top: 100,
                right: 30,
                child: _FloatingSymbol(
                  symbol: '×',
                  size: 30,
                  color: Color(0xFF7E57C2),
                  angle: 0.15,
                ),
              ),

              const Positioned(
                bottom: 160,
                left: 24,
                child: _FloatingSymbol(
                  symbol: '÷',
                  size: 32,
                  color: Color(0xFF42A5F5),
                  angle: 0.12,
                ),
              ),

              const Positioned(
                bottom: 100,
                right: 35,
                child: _FloatingSymbol(
                  symbol: '=',
                  size: 30,
                  color: Color(0xFF66BB6A),
                  angle: -0.1,
                ),
              ),

              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      // Game character
                      Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.12),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Brain / character
                            Container(
                              width: 115,
                              height: 105,
                              decoration: BoxDecoration(
                                color: const Color(0xFF8ED081),
                                borderRadius: BorderRadius.circular(45),
                                border: Border.all(
                                  color: const Color(0xFF5FAF55),
                                  width: 4,
                                ),
                              ),
                            ),

                            // Eyes
                            Positioned(
                              top: 60,
                              left: 65,
                              child: Container(
                                width: 12,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF263238),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),

                            Positioned(
                              top: 60,
                              right: 65,
                              child: Container(
                                width: 12,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF263238),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),

                            // Smile
                            Positioned(
                              top: 88,
                              child: Container(
                                width: 38,
                                height: 18,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFF263238),
                                      width: 3,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Small graduation cap
                            Positioned(
                              top: 27,
                              child: Transform.rotate(
                                angle: -0.08,
                                child: Container(
                                  width: 85,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6C4AB6),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              top: 18,
                              right: 48,
                              child: Container(
                                width: 12,
                                height: 18,
                                color: const Color(0xFF6C4AB6),
                              ),
                            ),

                            const Positioned(
                              top: 12,
                              right: 40,
                              child: Text(
                                '★',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFFFFB300),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Title
                      const Text(
                        'Ready to',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF40364D),
                        ),
                      ),

                      const SizedBox(height: 2),

                      const Text(
                        'PLAY WITH NUMBERS?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 29,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                          color: Color(0xFF6C4AB6),
                        ),
                      ),

                      const SizedBox(height: 14),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Solve • Improve • Level Up 🚀',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF574C62),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Start button
                      SizedBox(
                        width: double.infinity,
                        height: 64,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GameScreen(),
                      ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C4AB6),
                            foregroundColor: Colors.white,
                            elevation: 7,
                            shadowColor:
                                const Color(0xFF6C4AB6).withOpacity(0.35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'LET\'S PLAY',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                '🎮',
                                style: TextStyle(fontSize: 23),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Small information card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.72),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              '🧠',
                              style: TextStyle(fontSize: 26),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Your game adapts to your calculation skills!',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF554A60),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingSymbol extends StatelessWidget {
  final String symbol;
  final double size;
  final Color color;
  final double angle;

  const _FloatingSymbol({
    required this.symbol,
    required this.size,
    required this.color,
    required this.angle,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Text(
        symbol,
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w900,
          color: color,
        ),
      ),
    );
  }
}