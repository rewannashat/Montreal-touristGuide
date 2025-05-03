import 'dart:async';
import 'package:flutter/material.dart';

import 'onBoarding-view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Scale animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    _scaleAnimation = Tween<double>(begin: 0.8, end: 2.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Timer to move to HomeScreen
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) => OnBoardingView()),
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
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFa36bbf),
              Color(0xFFb876c5),
              Color(0xFFc071c3),
              Color(0xFFb767be),
            ],
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              'assets/images/logo.png',
              width: 150,
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}
