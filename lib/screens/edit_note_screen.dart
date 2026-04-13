import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../models/note.dart';
import '../services/database_service.dart';
import 'package:secure_notes/l10n/app_localizations.dart';

class EditNoteScreen extends StatefulWidget {
  final Note note;

  const EditNoteScreen({super.key, required this.note});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final validForm = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController positionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    descriptionController = TextEditingController(
      text: widget.note.description,
    );
    positionController = TextEditingController(
      text: widget.note.position.toString(),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    positionController.dispose();
    super.dispose();
  }

  Future<void> updateNote() async {
    if (validForm.currentState!.validate()) {
      final int positionValue =
          int.tryParse(positionController.text) ?? widget.note.position;

      final updatedNote = Note(
        id: widget.note.id,
        title: titleController.text,
        description: descriptionController.text,
        position: positionValue,
      );

      await DatabaseService.instance.updateNote(updatedNote);

      if (mounted) Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.editNote),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await DatabaseService.instance.deleteNote(widget.note.id!);
              if (mounted) Navigator.pop(context, true);
            },
          ),
          IconButton(
            onPressed: () async {
              await SharePlus.instance.share(
                ShareParams(
                  subject: widget.note.title,
                  text: '${widget.note.title}\n\n${widget.note.description}',
                ),
              );
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: validForm,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 8,
                  decoration: InputDecoration(
                    labelText: l10n.description,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: positionController,
                  decoration: InputDecoration(
                    labelText: 'Position',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: updateNote,
                    icon: const Icon(Icons.save),
                    label: Text(l10n.saveNote),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
