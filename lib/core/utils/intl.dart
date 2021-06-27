import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

const languages = ['en', 'tr', 'ru'];

/// Internationalization class
/// which generates language codes by [ISO 639-1].
class Intl {
  late Locale locale;

  @visibleForTesting
  Map<String, String>? localizedValues;

  List<String>? supportedLocales;

  IntlDelegate get delegate => const IntlDelegate();

  // Helper method to keep the code in the widgets concise.
  // Localizations are accessed using an InheritedWidget "of" syntax.
  Intl? of(BuildContext context) => Localizations.of<Intl>(context, Intl);

  // This variadic method will be called from every widget which,
  // needs a localized (formatted) text.
  // Example:
  /// ```dart
  /// "account.hello": "Hello %1, your age is %2"
  /// lomsa.intl.of(context).fmt('account.hello', ['Ismael', '16'])
  /// ```
  // Output should be: [Hello Ismael, your age is 16].
  String fmt(String key, [List<dynamic>? args]) {
    if (args == null || args.isEmpty) {
      return localizedValues?[key] ?? key;
    }

    int _idx;
    String formatted = localizedValues![key]!.replaceAllMapped(
        RegExp(r'\%[0-9]{1,3}', multiLine: true), (Match match) {
      _idx = int.parse(match[0]!.substring(1)) - 1;

      return (args.asMap()[_idx] ?? match[0]).toString();
    });

    return formatted;
  }

  // This method loads the language JSON file from the "assets/i18n" folder.
  // Then decodes getted JSON and returns it as [MapEntry].
  Future<Map<String, dynamic>> load() async {
    final jsonString =
        await rootBundle.loadString('assets/i18n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    // Convert json values to string.
    localizedValues = jsonMap.map(
      (key, value) => MapEntry(key, value.toString()),
    );
    return localizedValues!;
  }
}

// LocalizationsDelegate is a factory for a set of localized resources.
// In this case, the localized strings will be gotten in an Intl object.
@immutable
@visibleForTesting
class IntlDelegate extends LocalizationsDelegate<Intl> {
  // This delegate instance won't change. (it doesn't even have fields!).
  // It can provide a constant constructor.
  const IntlDelegate();

  @override
  bool isSupported(Locale locale) => languages.contains(locale.languageCode);

  @override
  Future<Intl> load(Locale locale) async {
    final Intl intl = Intl();
    intl.locale = locale;
    await intl.load();
    return intl;
  }

  @override
  bool shouldReload(IntlDelegate old) => false;
}
