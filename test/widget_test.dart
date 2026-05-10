import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(configureDependencies);

  testWidgets('shows login screen', (tester) async {
    await tester.pumpWidget(const FlowerApp());

    expect(find.text(AppStrings.login), findsWidgets);
    expect(find.text(AppStrings.email), findsWidgets);
    expect(find.text(AppStrings.password), findsWidgets);
  });
}
