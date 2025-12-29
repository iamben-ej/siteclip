import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 400,
              viewportFraction: 1.0,
              autoPlay: true,
            ),
            items: [
              _buildSlide('Slide 1: Welcome to SiteClip', Colors.blue),
              _buildSlide('Slide 2: Organize Photos Easily', Colors.green),
              _buildSlide('Slide 3: Collaborate with Teams', Colors.orange),
            ],
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => context.go('/signin'),
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide(String text, Color color) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
