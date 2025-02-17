// lib/screens/password_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'add_password_screen.dart';
import '../models/password_entry.dart';

class PasswordListScreen extends StatefulWidget {
  static const routeName = '/password-list';

  @override
  _PasswordListScreenState createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {
  List<PasswordEntry> _passwords = [];

  void _addPasswordEntry(PasswordEntry entry) {
    setState(() {
      _passwords.add(entry);
    });
  }

  void _editPasswordEntry(int index, PasswordEntry newEntry) {
    setState(() {
      _passwords[index] = newEntry;
    });
  }

  void _deletePasswordEntry(int index) {
    setState(() {
      _passwords.removeAt(index);
    });
  }

  void _copyToClipboard(String password) {
    Clipboard.setData(ClipboardData(text: password));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password copied to clipboard!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Password List')),
      body: _passwords.isEmpty
          ? Center(child: Text('No passwords added'))
          : ListView.builder(
              itemCount: _passwords.length,
              itemBuilder: (ctx, index) {
                final entry = _passwords[index];

                return Dismissible(
                  key: ValueKey(entry.website),
                  background: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.blue,
                    child: Icon(Icons.edit, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      // Swipe from left to right (edit)
                      final updatedEntry = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => AddPasswordScreen(
                            existingEntry: entry,
                            onSave: (newEntry) => _editPasswordEntry(index, newEntry),
                          ),
                        ),
                      );
                      return false; // Do not dismiss after edit
                    } else if (direction == DismissDirection.endToStart) {
                      // Swipe from right to left (delete)
                      _deletePasswordEntry(index);
                      return true; // Dismiss after delete
                    }
                    return false;
                  },
                  child: ListTile(
                    title: Text(entry.website),
                    subtitle: Text('Added on ${entry.dateAdded}'),
                    onTap: () => _copyToClipboard(entry.password),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newEntry = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => AddPasswordScreen(
                onSave: _addPasswordEntry,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}