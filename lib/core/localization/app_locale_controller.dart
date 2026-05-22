import 'package:flutter/material.dart';

class AppLocaleScope extends StatefulWidget {
  final Locale initialLocale;
  final Widget Function(Locale locale) builder;

  const AppLocaleScope({
    super.key,
    required this.initialLocale,
    required this.builder,
  });

  static void updateLocale(BuildContext context, String languageCode) {
    context.findAncestorStateOfType<_AppLocaleScopeState>()?._updateLocale(
      languageCode,
    );
  }

  @override
  State<AppLocaleScope> createState() => _AppLocaleScopeState();
}

class _AppLocaleScopeState extends State<AppLocaleScope> {
  late Locale _locale = widget.initialLocale;

  void _updateLocale(String languageCode) {
    final nextLocale = Locale(languageCode == 'ar' ? 'ar' : 'en');
    if (_locale == nextLocale) return;

    setState(() => _locale = nextLocale);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_locale);
  }
}
