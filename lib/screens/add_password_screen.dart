// lib/screens/add_password_screen.dart

import 'package:flutter/material.dart';
import '../models/password_entry.dart';

class AddPasswordScreen extends StatefulWidget {
  static const routeName = '/add-password';

  final PasswordEntry? existingEntry;
  final Function(PasswordEntry) onSave;

  AddPasswordScreen({this.existingEntry, required this.onSave});

  @override
  _AddPasswordScreenState createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    if (widget.existingEntry != null) {
      _websiteController.text = widget.existingEntry!.website;
      _passwordController.text = widget.existingEntry!.password;
    }
    super.initState();
  }

  void _saveEntry() {
    final newEntry = PasswordEntry(
      website: _websiteController.text,
      password: _passwordController.text,
      dateAdded: DateTime.now().toString(),
    );
    widget.onSave(newEntry);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.existingEntry == null ? 'Add Password' : 'Edit Password')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _websiteController,
              decoration: InputDecoration(labelText: 'Website'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveEntry,
              child: Text(widget.existingEntry == null ? 'Add' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
