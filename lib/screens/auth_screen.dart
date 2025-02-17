// lib/screens/auth_screen.dart

import 'package:flutter/material.dart';
import 'password_list_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // New variable to track visibility

  void _validateLogin() {
    if (_emailController.text == 'test@admin.com' && _passwordController.text == '12345678') {
      Navigator.of(context).pushReplacementNamed(PasswordListScreen.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
                    });
                  },
                ),
              ),
              obscureText: !_isPasswordVisible, // Control visibility based on the state
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validateLogin,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
