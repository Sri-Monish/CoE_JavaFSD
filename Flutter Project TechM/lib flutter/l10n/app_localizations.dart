import 'package:flutter/material.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': appLocalizationsEn,
    'es': appLocalizationsEs,
    'fr': appLocalizationsFr,
  };

  String get title => _localizedValues[locale.languageCode]!['title']!;
  String get welcomeMessage => _localizedValues[locale.languageCode]!['welcomeMessage']!;
  String get description => _localizedValues[locale.languageCode]!['description']!;
  String get calculateBMI => _localizedValues[locale.languageCode]!['calculateBMI']!;
  String get workouts => _localizedValues[locale.languageCode]!['workouts']!;
  String get dietTracker => _localizedValues[locale.languageCode]!['dietTracker']!;
  String get myWorkouts => _localizedValues[locale.languageCode]!['myWorkouts']!;
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
