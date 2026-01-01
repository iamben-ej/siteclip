import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:siteclip/core/constants/colors.dart';

class EmailInputScreen extends StatefulWidget {
  const EmailInputScreen({super.key});

  @override
  State<EmailInputScreen> createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends State<EmailInputScreen> {
  final _emailController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  bool _showCodeSection = false;
  bool _isLoading = false;
  bool _isValidEmail = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    final email = _emailController.text;
    setState(() {
      _isValidEmail =
          email.isNotEmpty && email.contains('@') && email.contains('.');
    });
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColors.surfaceBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            title: const Text(
              'Confirm Email',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            content: Text(
              'We will send a verification code to\n${_emailController.text} to confirm it is yours.',
              style: TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.left,
            ),
            actionsAlignment: MainAxisAlignment.end,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() => _showCodeSection = true);
                },
                child: Text(
                  'Send Code',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  void _resetToEmail() {
    setState(() {
      _showCodeSection = false;
      _pinController.clear();
    });
    _emailController.clear();
    _validateEmail();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 24, color: AppColors.textPrimary),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        border: Border.all(color: AppColors.borderDefault),
        borderRadius: BorderRadius.circular(16),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyBorderWith(
      border: Border.all(color: AppColors.primaryAction, width: 2),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color(0xFFE0E0E0),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.surfaceBackground,

      appBar: AppBar(
        backgroundColor: AppColors.surfaceBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: AppColors.textPrimary,
          onPressed: () => context.pop(),
        ),
      ),

      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 24),

                  TextFormField(
                    controller: _emailController,
                    enabled: !_showCodeSection,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      filled: true,
                      fillColor: AppColors.surfaceCard,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: AppColors.borderDefault),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: AppColors.borderDefault),
                      ),
                      suffixIcon:
                          _emailController.text.isNotEmpty
                              ? IconButton(
                                icon: Icon(
                                  _showCodeSection ? Icons.close : Icons.clear,
                                ),
                                onPressed:
                                    _showCodeSection
                                        ? _resetToEmail
                                        : _emailController.clear,
                              )
                              : null,
                    ),
                  ),

                  if (_showCodeSection) ...[
                    const SizedBox(height: 32),
                    Text(
                      'Verification code',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter the code we\'ve sent to your email',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 16),
                    Pinput(
                      controller: _pinController,
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      onCompleted: (pin) {
                        setState(() => _isLoading = true);
                        Future.delayed(
                          const Duration(seconds: 1),
                          () => context.go('/home'),
                        );
                      },
                    ),
                  ],

                  const SizedBox(height: 32),

                  if (!_showCodeSection)
                    ElevatedButton(
                      onPressed: _isValidEmail ? _showConfirmDialog : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isValidEmail
                                ? AppColors.primaryAction
                                : const Color(0xFFE0E0E0),
                        foregroundColor:
                            _isValidEmail
                                ? AppColors.textOnPrimary
                                : AppColors.textSecondary,
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                      children: [
                        const TextSpan(
                          text:
                              'By continuing, you acknowledge that you agree to our ',
                        ),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            if (_isLoading)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
