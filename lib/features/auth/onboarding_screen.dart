import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siteclip/core/constants/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  final List<String> _images = [
    'assets/onboarding1.png',
    'assets/onboarding2.png',
    'assets/onboarding3.png',
  ];

  final List<String> _descriptions = [
    'Capture project photos as you work and let the app organize everything for you automatically.',
    'Every photo is sorted by project stage and team member so nothing gets lost or mixed up.',
    'Export clear photo reports anytime even when work was done offline.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider.builder(
            carouselController: _controller,
            itemCount: 3,
            itemBuilder: (context, index, _) => _buildSlide(index),
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 1.0,
              onPageChanged: (index, _) => setState(() => _currentPage = index),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'SiteClip',
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    _descriptions[_currentPage],
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),
                _buildDots(),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () => context.go('/signin'),
                    child: const Text('Get Started'),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide(int index) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(_images[index], fit: BoxFit.cover),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.surfaceBackground.withOpacity(0.0),
                AppColors.surfaceBackground.withOpacity(0.1),
                AppColors.surfaceBackground.withOpacity(0.5),
                AppColors.surfaceBackground.withOpacity(0.9),
                AppColors.surfaceBackground,
              ],
              stops: const [0.0, 0.35, 0.55, 0.75, 1.0],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) => _buildDot(index)),
    );
  }

  Widget _buildDot(int index) {
    bool isActive = _currentPage == index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 32 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
