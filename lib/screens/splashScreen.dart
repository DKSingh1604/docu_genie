import 'dart:math';

import 'package:docu_genie/colors.dart';
import 'package:docu_genie/screens/home_screen.dart';
import 'package:docu_genie/screens/info_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _dropController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation1, _slideAnimation2;
  bool _showDropAnimation = false;
  Color _textColor1 = AppColor.blueColor;
  Color _textColor2 = AppColor.lightBlueColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _dropController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation1 = Tween<Offset>(
            begin: const Offset(-4.0, 0.0), end: const Offset(0.0, 0.0))
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _slideAnimation2 = Tween<Offset>(
            begin: const Offset(4.0, 0.0), end: const Offset(0.0, 0.0))
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward().then((_) {
      setState(() {
        _showDropAnimation = true;
      });
      _dropController.forward().then((_) => _navigateToHome());
    });

    Future.delayed(const Duration(milliseconds: 1350), () {
      if (mounted) {
        setState(() {
          _textColor1 = Colors.white;
          _textColor2 = Colors.white;
        });
      }
    });

    _navigateToHome();
  }

  @override
  void dispose() {
    _controller.dispose();
    _dropController.dispose();
    super.dispose();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(
              milliseconds: 500), // Adjust the duration as needed
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: const LoadingScreen(),
            );
          },
        ),
      );
    }
  }

  final Gradient gradient = const LinearGradient(colors: [
    Color.fromARGB(255, 6, 113, 201),
    Color.fromARGB(255, 2, 66, 118),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // CustomPaint background animation
          if (_showDropAnimation)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _dropController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: WaterDropPainter(
                        _dropController.value, const Color(0xFF0581FF)),
                  );
                },
              ),
            ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset('assets/images/logo.png'),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 5),
                SlideTransition(
                  position: _slideAnimation2,
                  child: Text(
                    '',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: _textColor2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Powered by DK Industries",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaterDropPainter extends CustomPainter {
  final double value;
  final Color backgroundColor;

  WaterDropPainter(this.value, this.backgroundColor); // Updated constructor

  @override
  void paint(Canvas canvas, Size size) {
    double diagonal = sqrt(size.width * size.width + size.height * size.height);
    Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.white, backgroundColor],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    double radius = diagonal * value * 0.5;

// Draw the circle for the drop effect
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // Duration for one full rotation
      vsync: this,
    )..repeat(); // Repeat the animation

    // Wait for 1 second, then navigate to the next screen
    // final user = FirebaseAuth.instance.currentUser;

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => InfoScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          child: Image.asset('assets/images/Loader.png', scale: 0.8),
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller.value * 2.0 * pi, // Rotate the image
              child: child,
            );
          },
        ),
      ),
    );
  }
}
