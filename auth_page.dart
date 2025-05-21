import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

import 'home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  String _username = '';
  String _password = '';

  Future<void> _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Image.asset(
          'assets/images/headphones1.png',
          fit: BoxFit.cover,
        ),
        Container(color: Colors.black.withOpacity(0.5)),
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Lottie.asset('assets/animations/headphones.json', height: 150),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Username',
                  ),
                  onChanged: (v) => _username = v,
                  validator: (v) => v == null || v.isEmpty ? 'Enter username' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Password',
                  ),
                  obscureText: true,
                  onChanged: (v) => _password = v,
                  validator: (v) => v == null || v.isEmpty ? 'Enter password' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}



