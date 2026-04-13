import 'package:flutter/material.dart';
import 'package:secure_notes/l10n/app_localizations.dart';
import 'package:secure_notes/main.dart';
import 'package:secure_notes/models/note.dart';
import 'package:secure_notes/screens/add_note_screen.dart';
import 'package:secure_notes/screens/edit_note_screen.dart';
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

  Future<void> _deleteNote(Note note) async {
    await DatabaseService.instance.deleteNote(note.id!);
    _loadNotes();
  }

  Future<void> _deleteAllNotes() async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.deleteAllTitle),
        content: Text(l10n.deleteAllMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DatabaseService.instance.deleteAllNotes();
      _loadNotes();
    }
  }

  Future<void> _reorderNotes(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) newIndex--;
    setState(() {
      final note = _notes.removeAt(oldIndex);
      _notes.insert(newIndex, note);
    });

    for (int i = 0; i < _notes.length; i++) {
      _notes[i].position = i;
      await DatabaseService.instance.updateNote(_notes[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          PopupMenuButton<ThemeMode>(
            icon: const Icon(Icons.brightness_6),
            tooltip: l10n.theme,
            onSelected: (mode) => themeNotifier.value = mode,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: ThemeMode.system,
                child: Row(
                  children: [
                    const Icon(Icons.brightness_auto),
                    const SizedBox(width: 8),
                    Text(l10n.systemTheme),
                  ],
                ),
              ),
              PopupMenuItem(
                value: ThemeMode.light,
                child: Row(
                  children: [
                    const Icon(Icons.light_mode),
                    const SizedBox(width: 8),
                    Text(l10n.lightMode),
                  ],
                ),
              ),
              PopupMenuItem(
                value: ThemeMode.dark,
                child: Row(
                  children: [
                    const Icon(Icons.dark_mode),
                    const SizedBox(width: 8),
                    Text(l10n.darkMode),
                  ],
                ),
              ),
            ],
          ),
          PopupMenuButton<Locale?>(
            icon: const Icon(Icons.language),
            tooltip: l10n.language,
            onSelected: (locale) => localeNotifier.value = locale,
            itemBuilder: (context) => [
              const PopupMenuItem(value: Locale('en'), child: Text('English')),
              const PopupMenuItem(value: Locale('ar'), child: Text('العربية')),
              const PopupMenuItem(value: Locale('ja'), child: Text('日本語')),
            ],
          ),
          if (_notes.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              tooltip: l10n.deleteAll,
              onPressed: _deleteAllNotes,
            ),
        ],
      ),

      body: _notes.isEmpty
          ? Center(
              child: Text(
                l10n.noNotes,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ReorderableListView.builder(
              itemCount: _notes.length,
              onReorder: _reorderNotes,
              itemBuilder: (ctx, index) {
                final note = _notes[index];
                return Dismissible(
                  key: ValueKey(note.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => _deleteNote(note),
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(
                        color: Colors.grey.shade200,
                      ), // Subtle border
                    ),
                    child: ListTile(
                      key: ValueKey(note.id),
                      title: Text(
                        note.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        note.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditNoteScreen(note: note),
                          ),
                        );
                        _loadNotes();
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddNoteScreen()),
          );
          _loadNotes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
