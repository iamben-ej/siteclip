import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SiteClip'), centerTitle: true),
      body: const Center(
        child: Text(
          'Home Screen\n(Welcome! Projects will appear here)',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
