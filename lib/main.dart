import 'package:flower_app/config/security_storage/security_storage.dart';
import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/values/api_param.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/intent/cart_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'config/di/di.dart';
import 'core/router/app_router.dart';
import 'core/theme/theme.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  final initialLocation = await _getInitialLocation();
  runApp(FlowerApp(initialLocation: initialLocation));
}

Future<String> _getInitialLocation() async {
  final securityStorage = getIt<SecurityStorage>();
  final token = await securityStorage.getSecuredString(ApiParam.token);
  if (token.isNotEmpty) {
    return AppRouterPaths.kAppSections;
  }
  return AppRouterPaths.kLoginView;
}

class FlowerApp extends StatelessWidget {
  final String initialLocation;

  const FlowerApp({
    super.key,
    this.initialLocation = AppRouterPaths.kLoginView,
  });

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
