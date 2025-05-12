import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Home/Main-view/main_view.dart';
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

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    _scaleAnimation = Tween<double>(begin: 0.8, end: 2.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('is_first_time') ?? true;

    if (isFirstTime) {
      // Set the flag to false so it doesn't show again
      await prefs.setBool('is_first_time', false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  OnBoardingView()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainView()),
      );
    }
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
