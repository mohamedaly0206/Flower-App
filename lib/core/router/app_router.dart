import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/feature/app_sections/app_sections.dart';
import 'package:flower_app/feature/auth/login/presentation/view_model/login_cubit.dart';
import 'package:flower_app/feature/auth/login/presentation/views/login_view.dart';
import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/features/signup/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../values/app_strings.dart';

abstract class AppRouter {
  static GoRouter getRouter({
    String initialLocation = AppRouterPaths.kLoginView,
  }) => GoRouter(
    initialLocation: initialLocation,
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
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: AppRouterPaths.kAppSections,
        builder: (context, state) => const AppSections(),
      ),
      // GoRoute(
      //   path: AppRouterPaths.kSignUpView,
      //   builder: (context, state) => const SignUpView(),
      // ),
      // GoRoute(
      //   path: AppRouterPaths.kLoginView,
      //   builder: (context, state) => const LoginView(),
      // ),
      GoRoute(
        path: AppRouterPaths.kSignUpView,
        builder: (context, state) => const RegisterScreen(),
      ),
      // GoRoute(
      //   path: AppRouterPaths.kForgetPasswordView,
      //   builder: (context, state) => const ForgetPasswordView(),
      // ),
    ],
  );
}
