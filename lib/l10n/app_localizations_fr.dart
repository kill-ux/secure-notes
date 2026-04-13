// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Notes Sécurisées';

  @override
  String get authenticate => 'S\'authentifier';

  @override
  String get authMessage => 'Appuyez sur le bouton pour vous authentifier';

  @override
  String get authenticating => 'Authentification...';

  @override
  String get authFailed => 'L\'authentification a échoué. Réessayez.';

  @override
  String get biometricsUnavailable =>
      'Biométrie non disponible sur cet appareil';

  @override
  String get notes => 'Notes Sécurisées';

  @override
  String get noNotes =>
      'Aucune note pour le moment.\nAppuyez sur + pour en ajouter une.';

  @override
  String get deleteAll => 'Tout supprimer';

  @override
  String get deleteAllTitle => 'Supprimer toutes les notes';

  @override
  String get deleteAllMessage =>
      'Êtes-vous sûr de vouloir supprimer toutes les notes ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get addNote => 'Ajouter une note';

  @override
  String get editNote => 'Modifier la note';

  @override
  String get title => 'Titre';

  @override
  String get description => 'Description';

  @override
  String get titleEmpty => 'Le titre ne peut pas être vide';

  @override
  String get descriptionEmpty => 'La description ne peut pas être vide';

  @override
  String get saveNote => 'Enregistrer la note';

  @override
  String get saveChanges => 'Enregistrer les modifications';

  @override
  String get saving => 'Enregistrement...';

  @override
  String get language => 'Langue';

  @override
  String get theme => 'Thème';

  @override
  String get systemTheme => 'Système';

  @override
  String get lightMode => 'Clair';

  @override
  String get darkMode => 'Sombre';
}
