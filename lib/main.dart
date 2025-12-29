import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
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
