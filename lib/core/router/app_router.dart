import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/product_entity.dart';
import 'package:flower_app/core/shared_features/shared_view_model/cubit/home_shared_cubit.dart';
import 'package:flower_app/core/shared_features/shared_view_model/Intent/home_shared_intent.dart';
import 'package:flower_app/features/app_sections/categories/presentation/views/categories_view.dart';
import 'package:flower_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:flower_app/features/auth/forget_password/presentation/view/forget_password_screen.dart';
import 'package:flower_app/features/app_sections/app_sections.dart';
import 'package:flower_app/features/auth/login/presentation/view_model/login_cubit.dart';
import 'package:flower_app/features/auth/login/presentation/views/login_view.dart';
import 'package:flower_app/features/auth/signup/presentation/screens/register_screen.dart';
import 'package:flower_app/features/best_seller/presentation/view/best_seller_view.dart';
import 'package:flower_app/features/occasion/presentation/view_model/intent/occasion_intent.dart';
import 'package:flower_app/features/occasion/presentation/view/occasion_view.dart';
import 'package:flower_app/features/product_details/presentation/view/product_details_view.dart';
import 'package:flower_app/features/search/presentation/views/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flower_app/features/occasion/presentation/view_model/cubit/occasion_cubit.dart';
import 'package:flower_app/features/edite_profile/presentation/view_model/cubit/edite_profile_cubit.dart';
import 'package:flower_app/features/edite_profile/presentation/view/edite_profile_view.dart';
import '../../l10n/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey =
GlobalKey<NavigatorState>();

abstract class AppRouter {
  static GoRouter getRouter({
    String initialLocation = AppRouterPaths.kLoginView,
  }) => GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: initialLocation,
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          textAlign: TextAlign.center,
          AppLocalizations.of(context)!.errorMessage,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    ),
    routes: [
      GoRoute(
        path: AppRouterPaths.kSearchView,
        builder: (context, state) => BlocProvider.value(
          value: getIt<HomeSharedCubit>(),
          child: SearchView(),
        ),
      ),
      GoRoute(
        path: AppRouterPaths.kCategoriesView,
        builder: (context, state) => const CategoriesView(),
      ),
      GoRoute(
        path: AppRouterPaths.kLoginView,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: AppRouterPaths.kAppSections,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              getIt<HomeSharedCubit>()
                ..handleHomeSharedIntent(GetAllHomeDataIntent()),
          child: const AppSections(),
        ),
      ),
      GoRoute(
        path: AppRouterPaths.kForgetPasswordView,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<ForgetPasswordCubit>(),
          child: ForgetPasswordScreen(),
        ),
      ),
      GoRoute(
        path: AppRouterPaths.kSignUpView,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRouterPaths.kProductDetailsView,
        builder: (context, state) =>
            ProductDetailsView(product: state.extra as ProductEntity),
      ),
      GoRoute(
        path: AppRouterPaths.kBestSellerView,
        builder: (context, state) => BlocProvider.value(
          value: getIt<HomeSharedCubit>()
            ..handleHomeSharedIntent(GetBestSellersIntent()),
          child: const BestSellerView(),
        ),
      ),
      GoRoute(
        path: AppRouterPaths.kOccasionView,
        builder: (context, state) {
          final extraParam = state.extra;
          final initialIndex = extraParam is int ? extraParam : 0;

          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<OccasionCubit>()
                  ..handleIntent(
                    LoadOccasionsIntent(initialIndex: initialIndex),
                  ),
              ),
              BlocProvider.value(value: getIt<HomeSharedCubit>()),
            ],
            child: const OccasionView(),
          );
        },
      ),
      GoRoute(
        path: AppRouterPaths.kEditProfileView,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<EditeProfileCubit>(),
          child: const EditeProfileView(),
        ),
      ),
    ],
  );
}
