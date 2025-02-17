// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/auth_screen.dart';
import 'screens/password_list_screen.dart';

void main() {
  runApp(PasswordManagerApp());
}

class PasswordManagerApp extends StatelessWidget {
  const PasswordManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Manager',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthScreen(),
      routes: {
        PasswordListScreen.routeName: (context) => PasswordListScreen(),
      },
    );
  }
}