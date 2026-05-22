import 'package:flower_app/config/security_storage/security_storage.dart';
import 'package:flower_app/core/localization/app_locale_controller.dart';
import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/values/api_param.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/intent/cart_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'config/di/di.dart';
import 'core/router/app_router.dart';
import 'core/theme/theme.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  final initialLocation = await _getInitialLocation();
  final initialLocale = await _getInitialLocale();
  runApp(
    AppLocaleScope(
      initialLocale: initialLocale,
      builder: (locale) {
        return FlowerApp(initialLocation: initialLocation, locale: locale);
      },
    ),
  );
}

Future<String> _getInitialLocation() async {
  final securityStorage = getIt<SecurityStorage>();
  final token = await securityStorage.getSecuredString(ApiParam.token);
  if (token.isNotEmpty) {
    return AppRouterPaths.kAppSections;
  }
  return AppRouterPaths.kLoginView;
}

Future<Locale> _getInitialLocale() async {
  final securityStorage = getIt<SecurityStorage>();
  final languageCode = await securityStorage.getSecuredString(
    ApiParam.languageCode,
  );

  return Locale(languageCode == 'ar' ? 'ar' : 'en');
}

class FlowerApp extends StatelessWidget {
  final String initialLocation;
  final Locale locale;
  static GoRouter? _router;
  static String? _routerInitialLocation;

  const FlowerApp({
    super.key,
    this.initialLocation = AppRouterPaths.kLoginView,
    this.locale = const Locale('en'),
  });

  GoRouter _getRouter() {
    if (_router == null || _routerInitialLocation != initialLocation) {
      _router = AppRouter.getRouter(initialLocation: initialLocation);
      _routerInitialLocation = initialLocation;
    }

    return _router!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CartCubit>()..cartIntentHandler(GetCartItemsIntent()),
      child: MaterialApp.router(
        routerConfig: AppRouter.getRouter(initialLocation: initialLocation),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('en'),
        builder: (context, child) {
          return ToastificationWrapper(child: child!);
        },
      ),
    );
  }
}
