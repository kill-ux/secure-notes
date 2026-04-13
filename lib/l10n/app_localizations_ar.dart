// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'ملاحظات آمنة';

  @override
  String get authenticate => 'تسجيل الدخول';

  @override
  String get authMessage => 'اضغط على الزر للمصادقة';

  @override
  String get authenticating => 'جارٍ المصادقة...';

  @override
  String get authFailed => 'فشلت المصادقة. حاول مرة أخرى.';

  @override
  String get biometricsUnavailable =>
      'المقاييس الحيوية غير متاحة على هذا الجهاز';

  @override
  String get notes => 'ملاحظات آمنة';

  @override
  String get noNotes => 'لا توجد ملاحظات بعد.\nاضغط + لإضافة واحدة.';

  @override
  String get deleteAll => 'حذف الكل';

  @override
  String get deleteAllTitle => 'حذف جميع الملاحظات';

  @override
  String get deleteAllMessage => 'هل أنت متأكد أنك تريد حذف جميع الملاحظات؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get addNote => 'إضافة ملاحظة';

  @override
  String get editNote => 'تعديل الملاحظة';

  @override
  String get title => 'العنوان';

  @override
  String get description => 'الوصف';

  @override
  String get titleEmpty => 'العنوان لا يمكن أن يكون فارغاً';

  @override
  String get descriptionEmpty => 'الوصف لا يمكن أن يكون فارغاً';

  @override
  String get saveNote => 'حفظ الملاحظة';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get saving => '...جارٍ الحفظ';

  @override
  String get language => 'اللغة';
}
