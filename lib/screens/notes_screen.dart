import 'package:flutter/material.dart';
import 'package:secure_notes/models/note.dart';
import 'package:secure_notes/services/database_service.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await DatabaseService.instance.getAllNotes();
    setState(() => _notes = notes);
  }

  Future<void> _deleteAllNotes() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete All Notes'),
        content: const Text('Are you sure you want to delete all notes?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DatabaseService.instance.deleteAllNotes();
      
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Secure Notes'),
      actions: [
        if (_notes.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Delete All',
            onPressed: _deleteAllNotes,
          ),
      ],
    ),
  );
}
