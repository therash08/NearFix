import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

class UserLoginScreen extends ConsumerStatefulWidget {
  const UserLoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends ConsumerState<UserLoginScreen> {
  final _phoneCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _continue() {
    final phone = _phoneCtrl.text.trim();
    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter phone number')),
      );
      return;
    }
    // OTP backend is not connected — present demo login option
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Phone Authentication Ready'),
        content: const Text(
          'Phone authentication is ready, but backend is not configured in this demo.\n\nUse Demo Login to continue into the app.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(c).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(c).pop();
              // Navigate to main user home in demo mode
              context.go('/home');
            },
            child: const Text('Demo Login'),
          ),
        ],
      ),
    );
  }

  void _googleSignIn() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Google Sign-In (mock)')));
  }

  void _forgotPassword() {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Forgot password'),
        content: const Text(
          'A password reset link will be sent to your email (mock).',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(c).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/role-selection'),
        ),
        title: const Text(
          'Sign in',
          style: TextStyle(color: AppTheme.textPrimary),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                const Icon(
                  Icons.person_outline,
                  size: 80,
                  color: AppTheme.primaryBlue,
                ),
                const SizedBox(height: 18),
                const Text(
                  'Phone number login',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Phone authentication is ready. Use Demo Login to continue.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _phoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixText: '+91 ',
                    hintText: 'Phone number',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loading ? null : _continue,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _loading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Continue'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    SizedBox(width: 12),
                    Text(
                      'Or continue with',
                      style: TextStyle(color: AppTheme.textSecondary),
                    ),
                    SizedBox(width: 12),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _googleSignIn,
                  icon: const Icon(
                    Icons.g_mobiledata,
                    color: AppTheme.textPrimary,
                  ),
                  label: const Text('Continue with Google'),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: _forgotPassword,
                  child: const Text('Forgot password?'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => context.go('/signup-user'),
                  child: const Text('Don\'t have an account? Create one'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
