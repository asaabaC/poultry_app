import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _showWelcomeText = false; // Control when the welcome text shows

  @override
  void initState() {
    super.initState();

    // Animation controller with 3 seconds duration
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Slide animation for the hen image
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from below the screen
      end: Offset.zero, // End in the middle
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start the animation when the screen is initialized
    _controller.forward();

    // After animation completes, show the welcome message and navigate
    Future.delayed(const Duration(seconds: 3), () {
      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          _showWelcomeText = true;
        });

        // Navigate to Login Screen after showing the welcome message
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        });
      }
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
      backgroundColor: Colors.orange, // Orange background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated hen image
            SlideTransition(
              position: _slideAnimation,
              child: const Image(
                image: AssetImage(
                    'assets/hen_151155842_1000.jpg'), // Path to your hen image
                height: 150, // Adjust size of the hen image
                width: 150,
              ),
            ),
            // Welcome text that appears after the animation
            if (_showWelcomeText)
              const Padding(
                padding: EdgeInsets.only(top: 16.0), // Add spacing below the hen image
                child: Text(
                  'Flock Together, Grow Smarter!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Arial',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
