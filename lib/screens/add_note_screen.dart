import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/database_service.dart';
import 'package:secure_notes/l10n/app_localizations.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final validForm = GlobalKey<FormState>();
  
  // get texte
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final positionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    positionController.dispose();
    super.dispose();
  }

  // Fonction pour sauvegarder la note
  Future<void> savingNote() async {
    // verification formulaire
    if (validForm.currentState!.validate()) {
      final allNotes = await DatabaseService.instance.getAllNotes();
      final int nextPosition = allNotes.length;
      // final int positionValue = int.tryParse(positionController.text) ?? 0;

      final newNote = Note(
        title: titleController.text,
        description: descriptionController.text,
        position: nextPosition,
      );

      await DatabaseService.instance.addNote(newNote);

      if (mounted) Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addNote),
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
                  decoration: InputDecoration(
                    labelText: l10n.title,
                    border: OutlineInputBorder(),
                  ),
                  
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.titleEmpty;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: l10n.description,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.descriptionEmpty;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: positionController,
                  decoration: const InputDecoration(
                    labelText: 'Position (Index)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: savingNote,
                    child: Text(l10n.saveNote),
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