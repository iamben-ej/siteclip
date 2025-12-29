import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/email-input'),
              child: const Text('Continue with Email'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/home'), // Fake success to home
              child: const Text('Continue with Google'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/home'), // Fake success to home
              child: const Text('Continue with Apple'),
            ),
          ],
        ),
      ),
    );
  }
}
