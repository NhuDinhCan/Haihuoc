import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const LoveApp());
}

class LoveApp extends StatelessWidget {
  const LoveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LovePage(),
    );
  }
}

class LovePage extends StatefulWidget {
  const LovePage({super.key});

  @override
  State<LovePage> createState() => _LovePageState();
}

class _LovePageState extends State<LovePage> with TickerProviderStateMixin {
  bool accepted = false;

  double noX = 120;
  double noY = 560;

  late AnimationController heartController;
  late AnimationController buttonController;
  late AnimationController successController;

  @override
  void initState() {
    super.initState();

    heartController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
      lowerBound: 0.95,
      upperBound: 1.08,
    )..repeat(reverse: true);

    successController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    heartController.dispose();
    buttonController.dispose();
    successController.dispose();
    super.dispose();
  }

  void acceptLove() {
    setState(() {
      accepted = true;
    });
    successController.forward();
  }

  void moveNoButton() {
    final random = Random();
    final size = MediaQuery.of(context).size;

    setState(() {
      noX = random.nextDouble() * (size.width - 140);
      noY = 120 + random.nextDouble() * (size.height - 220);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: accepted
                ? [
              Colors.pink.shade200,
              Colors.pinkAccent.shade100,
              Colors.white,
            ]
                : [
              Colors.deepPurple.shade900,
              Colors.pink.shade300,
              Colors.pink.shade50,
            ],
          ),
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: heartController,
              builder: (context, child) {
                return CustomPaint(
                  size: MediaQuery.of(context).size,
                  painter: HeartPainter(heartController.value),
                );
              },
            ),

            if (accepted)
              Center(child: successView())
            else ...[
              Center(child: questionView()),

              AnimatedPositioned(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutBack,
                left: noX,
                top: noY,
                child: GestureDetector(
                  onTap: moveNoButton,
                  child: ElevatedButton(
                    onPressed: moveNoButton,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade600,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                    ),
                    child: const Text(
                      "Từ chối 😏",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget questionView() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "🐻",
            style: TextStyle(fontSize: 95),
          ),
          const SizedBox(height: 20),
          const Text(
            "EM có một điều muốn hỏi...",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Cj Ly có đồng ý làm người yêu em không? 💖",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              height: 1.3,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.pinkAccent,
                  blurRadius: 18,
                ),
              ],
            ),
          ),
          const SizedBox(height: 45),

          ScaleTransition(
            scale: buttonController,
            child: GestureDetector(
              onTap: acceptLove,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 42,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.pinkAccent,
                      Colors.redAccent,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pinkAccent.withOpacity(0.6),
                      blurRadius: 25,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: const Text(
                  "ĐỒNG Ý ❤️",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 90),
        ],
      ),
    );
  }

  Widget successView() {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: successController,
        curve: Curves.elasticOut,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "🎉💖🎉",
              style: TextStyle(fontSize: 70),
            ),
            const SizedBox(height: 20),
            const Text(
              "YAYYY!",
              style: TextStyle(
                fontSize: 48,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.pink,
                    blurRadius: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              "Thành công rồi 💕",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: const Text(
                "Từ nay chj là của em nhé 🥰❤️\nAnh hứa sẽ thương em thật nhiều!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21,
                  height: 1.5,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 35),
            const Icon(
              Icons.favorite,
              size: 95,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class HeartPainter extends CustomPainter {
  final double progress;
  final Random random = Random(10);

  HeartPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < 35; i++) {
      final x = random.nextDouble() * size.width;
      final speed = 0.25 + random.nextDouble() * 0.75;
      final startY = random.nextDouble() * size.height;
      final y = (startY - progress * size.height * speed) % size.height;

      final opacity = 0.25 + random.nextDouble() * 0.65;
      final fontSize = 16 + random.nextDouble() * 24;

      textPainter.text = TextSpan(
        text: i % 3 == 0
            ? "💖"
            : i % 3 == 1
            ? "💕"
            : "✨",
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white.withOpacity(opacity),
        ),
      );

      textPainter.layout();
      textPainter.paint(canvas, Offset(x, y));
    }
  }

  @override
  bool shouldRepaint(covariant HeartPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}