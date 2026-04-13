import 'package:flutter/material.dart';
import 'package:secure_notes/l10n/app_localizations.dart';
import 'package:secure_notes/screens/auth_screen.dart';

final localeNotifier = ValueNotifier<Locale?>(null);
final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale?>(
      valueListenable: localeNotifier,
      builder: (context, locale, child) {
        return ValueListenableBuilder(
          valueListenable: themeNotifier,
          builder: (context, themeMode, child) {
            return MaterialApp(
              onGenerateTitle: (context) =>
                  AppLocalizations.of(context)!.appTitle,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.indigo,
                  brightness: Brightness.dark,
                ),
                useMaterial3: true,
              ),
              themeMode: themeMode,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: locale,
              home: const AuthScreen(),
            );
          },
        );
      },
    );
  }
}
