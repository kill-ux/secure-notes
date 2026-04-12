import 'package:flutter/material.dart';
import '../models/note.dart';

class EditNoteScreen extends StatelessWidget {
  final Note note;
  const EditNoteScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Edit Note — Coming Soon')),
    );
  }
}