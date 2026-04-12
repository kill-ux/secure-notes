// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Secure Notes';

  @override
  String get authenticate => 'Authenticate';

  @override
  String get authMessage => 'Press the button to authenticate';

  @override
  String get authenticating => 'Authenticating...';

  @override
  String get authFailed => 'Authentication failed. Try again.';

  @override
  String get biometricsUnavailable => 'Biometrics not available on this device';

  @override
  String get notes => 'Secure Notes';

  @override
  String get noNotes => 'No notes yet.\nTap + to add one.';

  @override
  String get deleteAll => 'Delete All';

  @override
  String get deleteAllTitle => 'Delete All Notes';

  @override
  String get deleteAllMessage => 'Are you sure you want to delete all notes?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get addNote => 'Add Note';

  @override
  String get editNote => 'Edit Note';

  @override
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get titleEmpty => 'Title cannot be empty';

  @override
  String get descriptionEmpty => 'Description cannot be empty';

  @override
  String get saveNote => 'Save Note';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get saving => 'Saving...';
}
