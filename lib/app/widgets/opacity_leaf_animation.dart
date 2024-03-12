import 'dart:async';
import 'package:flutter/material.dart';
import '../screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/leafImage.png.png', // Replace with your leaf image path
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 30),
            const Text(
              'SOCIAL SEED',
              style: TextStyle(
                color: Colors.red,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red, // Red background color
      body: Center(
        child: OpacityAnimationWidget(),
      ),
    );
  }
}

class OpacityAnimationWidget extends StatefulWidget {
  const OpacityAnimationWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OpacityAnimationWidgetState createState() => _OpacityAnimationWidgetState();
}

class _OpacityAnimationWidgetState extends State<OpacityAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Total duration for the animations
    );

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.3), // Opacity animation duration
      ),
    );

    _controller.forward(); // Start the animation
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // ignore: sized_box_for_whitespace
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: MediaQuery.of(context).size.height - 50,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (_controller.value >= 0.3)
                  Opacity(
                    opacity: _opacityAnimation.value,
                    child: Center(
                      child: Image.asset(
                        'assets/17257295_2004.i305.008_office_scenes_set-04.jpg', // Replace with your image path
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ),
                if (_controller.value >= 0.6)
                  Positioned(
                    top: 520,
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: const Text(
                        'Feuling Connections,\nSparking',
                        style: TextStyle(fontSize: 24,
                        color:Colors.red,
                        fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                if (_controller.value >= 0.9)
                  Positioned(
                    bottom: 50 + (_controller.value - 0.9) * 100,
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: ElevatedButton(
                       
                        onPressed: () {
                          Navigator.push(
                          context,  
                       MaterialPageRoute(builder: (context) => const SignUpScreen())
                      );
                      },
                         style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(10)
                        ),
                        child: const Text('Start your Journey Now'),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
