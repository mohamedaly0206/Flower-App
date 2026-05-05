import 'package:flutter/material.dart';
import 'config/di/di.dart';
import 'core/router/app_router.dart';
import 'core/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const FlowerApp());
}

class FlowerApp extends StatelessWidget {
  const FlowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.getRouter(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
    );
  }
}
