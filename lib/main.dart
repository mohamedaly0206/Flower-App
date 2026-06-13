import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flower_app/config/security_storage/security_storage.dart';
import 'package:flower_app/core/localization/app_locale_controller.dart';
import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/view_model/cubit/user_addresses_cubit.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/view_model/intent/user_addresses_intent.dart';
import 'package:flower_app/core/values/api_param.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/intent/cart_intent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:toastification/toastification.dart';
import 'config/di/di.dart';
import 'core/router/app_router.dart';
import 'core/theme/theme.dart';
import 'core/utilities/notification_service.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ),
  );
  await remoteConfig.setDefaults(const {
    AppStrings.firebaseDeliveryDaysConfig: 2,
  });

  // Fetch the latest values from Firebase
  await remoteConfig.fetchAndActivate();
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
  FlutterError.onError = (FlutterErrorDetails details) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  const mapboxToken = String.fromEnvironment('MAPBOX_ACCESS_TOKEN');

  MapboxOptions.setAccessToken(mapboxToken);
  configureDependencies();
  final notificationService = NotificationService();
  await notificationService.initialize();

  final initialLocation = await _getInitialLocation();
  final initialLocale = await _getInitialLocale();
  await initializeDateFormatting();
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
  if (token.isNotEmpty && token != 'GUEST') {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<CartCubit>()..cartIntentHandler(GetCartItemsIntent()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<UserAddressesCubit>()
                ..handleIntent(const FetchAddressesIntent()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _getRouter(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        builder: (context, child) {
          return ToastificationWrapper(child: child!);
        },
      ),
    );
  }
}
