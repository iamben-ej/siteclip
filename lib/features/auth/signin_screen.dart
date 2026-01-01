import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:siteclip/core/constants/colors.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBackground,
      body: SafeArea(
        child: Stack(
          children: [
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
                  const SizedBox(
                    height: 48,
                  ), // Space between heading and first button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ElevatedButton(
                      onPressed: () => context.push('/email-input'),
                      child: const Text(
                        'Continue with Email',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Or divider
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(color: AppColors.borderDefault),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                        Expanded(
                          child: Divider(color: AppColors.borderDefault),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Continue with Google
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: OutlinedButton.icon(
                      onPressed: () => context.go('/home'), // Fake to home
                      icon: SvgPicture.asset(
                        'assets/google_logo.svg',
                        width: 24,
                        height: 24,
                      ),
                      label: const Text(
                        'Continue with Google',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        minimumSize: const Size(double.infinity, 48),
                        side: BorderSide(color: AppColors.borderDefault),
                        backgroundColor: AppColors.surfaceCard,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Continue with Apple
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: OutlinedButton.icon(
                      onPressed: () => context.go('/home'), // Fake to home
                      icon: SvgPicture.asset(
                        'assets/apple_logo.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          AppColors.textPrimary,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: const Text(
                        'Continue with Apple',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        minimumSize: const Size(double.infinity, 48),
                        side: BorderSide(color: AppColors.borderDefault),
                        backgroundColor: AppColors.surfaceCard,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50), // Matches onboarding bottom space
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
