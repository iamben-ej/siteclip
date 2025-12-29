import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmailInputScreen extends StatefulWidget {
  const EmailInputScreen({super.key});

  @override
  State<EmailInputScreen> createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends State<EmailInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  bool _showCodeField = false;

  @override
  void initState() {
    super.initState();
    _codeController.addListener(_checkCodeLength);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _checkCodeLength() {
    if (_codeController.text.length == 6) {
      // Fake auth success - navigate to home
      context.go('/home');
    }
  }

  void _showPopup() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Verify Email'),
            content: Text(
              'We\'ll send a 6-digit code to ${_emailController.text}.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() => _showCodeField = true);
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Email')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              if (_showCodeField)
                TextField(
                  controller: _codeController,
                  decoration: const InputDecoration(labelText: '6-Digit Code'),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && !_showCodeField) {
                    _showPopup();
                  }
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
