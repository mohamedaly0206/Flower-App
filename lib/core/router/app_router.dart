import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/shared_features/shared_view_model/Intent/home_shared_intent.dart';
import 'package:flower_app/core/shared_features/shared_view_model/cubit/home_shared_cubit.dart';
import 'package:flower_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:flower_app/features/auth/forget_password/presentation/view/forget_password_screen.dart';
import 'package:flower_app/features/app_sections/app_sections.dart';
import 'package:flower_app/features/auth/login/presentation/view_model/login_cubit.dart';
import 'package:flower_app/features/auth/login/presentation/views/login_view.dart';
import 'package:flower_app/features/auth/signup/presentation/screens/register_screen.dart';
import 'package:flower_app/features/best_seller/presentation/view/best_seller_view.dart';
import 'package:flower_app/features/occasion/presentation/view_model/occasion_cubit.dart';
import 'package:flower_app/features/occasion/presentation/views/occasion_view.dart';
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
          textAlign: TextAlign.center,
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
      GoRoute(
        path: AppRouterPaths.kForgetPasswordView,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<ForgetPasswordCubit>(),
          child: ForgetPasswordScreen(),
        ),
      ),
      // GoRoute(
      //   path: AppRouterPaths.kLoginView,
      //   builder: (context, state) => const LoginView(),
      // ),
      GoRoute(
        path: AppRouterPaths.kSignUpView,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRouterPaths.kBestSellerView,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              getIt<HomeSharedCubit>()
                ..handleHomeSharedIntent(GetBestSellersIntent()),
          child: const BestSellerView(),
        ),
      ),
      // GoRoute(
      //   path: AppRouterPaths.kForgetPasswordView,
      //   builder: (context, state) => const ForgetPasswordView(),
      // ),
      GoRoute(
        path: AppRouterPaths.kOccasionView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => getIt<OccasionCubit>()..getOccasions(),
            ),
            BlocProvider(
              create: (_) => getIt<HomeSharedCubit>(),
            ),
          ],
          child: const OccasionView(),
        ),
      ),
    ],
  );
}
