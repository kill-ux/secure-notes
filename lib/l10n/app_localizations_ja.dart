// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'セキュアノート';

  @override
  String get authenticate => '認証する';

  @override
  String get authMessage => 'ボタンを押して認証してください';

  @override
  String get authenticating => '認証中...';

  @override
  String get authFailed => '認証に失敗しました。もう一度お試しください。';

  @override
  String get biometricsUnavailable => 'このデバイスでは生体認証が利用できません';

  @override
  String get notes => 'セキュアノート';

  @override
  String get noNotes => 'ノートがありません。\n+ をタップして追加してください。';

  @override
  String get deleteAll => 'すべて削除';

  @override
  String get deleteAllTitle => 'すべてのノートを削除';

  @override
  String get deleteAllMessage => 'すべてのノートを削除してもよろしいですか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get addNote => 'ノートを追加';

  @override
  String get editNote => 'ノートを編集';

  @override
  String get title => 'タイトル';

  @override
  String get description => '説明';

  @override
  String get titleEmpty => 'タイトルを入力してください';

  @override
  String get descriptionEmpty => '説明を入力してください';

  @override
  String get saveNote => 'ノートを保存';

  @override
  String get saveChanges => '変更を保存';

  @override
  String get saving => '保存中...';

  @override
  String get language => '言語';
}
