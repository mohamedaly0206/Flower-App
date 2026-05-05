import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/feature/auth/login/presentation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../values/app_strings.dart';

abstract class AppRouter {
  static GoRouter getRouter() => GoRouter(
    initialLocation: AppRouterPaths.kLoginView,
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          AppStrings.errorMessage,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    ),
    routes: [
      GoRoute(
        path: AppRouterPaths.kLoginView,
        builder: (context, state) => const LoginView(),
      ),
      // GoRoute(
      //   path: AppRouterPaths.kSignUpView,
      //   builder: (context, state) => const SignUpView(),
      // ),
      // GoRoute(
      //   path: AppRouterPaths.kForgetPasswordView,
      //   builder: (context, state) => const ForgetPasswordView(),
      // ),
    ],
  );
}
