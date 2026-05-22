import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/router/app_router.dart';
import 'package:flower_app/l10n/app_localizations.dart';
 
import 'package:flower_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(configureDependencies);

  testWidgets('shows login screen', (tester) async {
    await tester.pumpWidget(const FlowerApp());

    expect(find.text(AppLocalizations.of(navigatorKey.currentContext!)!.login), findsWidgets);
    expect(find.text(AppLocalizations.of(navigatorKey.currentContext!)!.email), findsWidgets);
    expect(find.text(AppLocalizations.of(navigatorKey.currentContext!)!.password), findsWidgets);
  });
}
