import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siteclip/core/constants/colors.dart';
import 'package:siteclip/features/auth/onboarding_screen.dart';
import 'package:siteclip/features/auth/signin_screen.dart';
import 'package:siteclip/features/auth/email_input_screen.dart';
import 'package:siteclip/features/home/home_screen.dart';

void main() => runApp(const SiteClipApp());

class SiteClipApp extends StatelessWidget {
  const SiteClipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SiteClip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.surfaceBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryAction,
          primary: AppColors.primaryAction,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(color: AppColors.textSecondary, fontSize: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryAction,
            foregroundColor: AppColors.textOnPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
      ),
      routerConfig: GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const OnboardingScreen(),
          ),
          GoRoute(
            path: '/signin',
            builder: (context, state) => const SignInScreen(),
          ),
          GoRoute(
            path: '/email-input',
            builder: (context, state) => const EmailInputScreen(),
          ),
          GoRoute(
            path: '/home',
            builder:
                (context, state) => const HomeScreen(), // Placeholder for now
          ),
        ],
      ),
    );
  }
}
