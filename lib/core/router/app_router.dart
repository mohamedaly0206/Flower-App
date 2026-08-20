import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/product_entity.dart';
import 'package:flower_app/core/shared_features/shared_view_model/Intent/home_shared_intent.dart';
import 'package:flower_app/core/shared_features/shared_view_model/cubit/home_shared_cubit.dart';
import 'package:flower_app/features/app_sections/app_sections.dart';
import 'package:flower_app/features/app_sections/categories/presentation/views/categories_view.dart';
import 'package:flower_app/features/notifications/presentation/views/notification_view.dart';
import 'package:flower_app/features/auth/forget_password/presentation/view/forget_password_screen.dart';
import 'package:flower_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:flower_app/features/auth/login/presentation/view_model/cubit/login_cubit.dart';
import 'package:flower_app/features/auth/login/presentation/views/login_view.dart';
import 'package:flower_app/features/auth/signup/presentation/screens/register_screen.dart';
import 'package:flower_app/features/best_seller/presentation/view/best_seller_view.dart';
import 'package:flower_app/features/change_password/presentation/view/change_password_view.dart';
import 'package:flower_app/features/change_password/presentation/view_model/cubit/change_password_cubit.dart';
import 'package:flower_app/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentation/views/checkout_view.dart';
import 'package:flower_app/features/checkout/presentation/widgets/credit_card_web_view_payment.dart';
import 'package:flower_app/features/occasion/presentation/view_model/intent/occasion_intent.dart';
import 'package:flower_app/features/edit_profile/presentation/view/edit_profile_view.dart';
import 'package:flower_app/features/edit_profile/presentation/view_model/cubit/edit_profile_cubit.dart';
import 'package:flower_app/features/occasion/presentation/view/occasion_view.dart';
import 'package:flower_app/features/occasion/presentation/view_model/cubit/occasion_cubit.dart';
import 'package:flower_app/features/orders/presentation/view_model/cubit/orders_cubit.dart';
import 'package:flower_app/features/orders/presentation/view_model/intent/orders_intent.dart';
import 'package:flower_app/features/orders/presentation/views/orders_view.dart';
import 'package:flower_app/features/product_details/presentation/view/product_details_view.dart';
import 'package:flower_app/features/search/presentation/views/search_view.dart';
import 'package:flower_app/features/tracking_order_map/presentation/models/order_tracking_args.dart';
import 'package:flower_app/features/tracking_order_map/presentation/view_model/cubit/tracker_order_cubit.dart';
import 'package:flower_app/features/tracking_order_map/presentation/views/tracker_order_view.dart';
import 'package:flower_app/features/tracking_order/presentation/view_model/intent/order_tracking_intent.dart';
import 'package:flower_app/features/tracking_order/presentation/views/tracking_order_view.dart';
import 'package:flower_app/features/tracking_order/presentation/view_model/cubit/order_tracking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/models/web_view_args.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/app_web_view.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
        builder: (context, state) {
          final extraParam = state.extra;
          final initialIndex = extraParam is int ? extraParam : 0;

          return BlocProvider(
            create: (context) =>
                getIt<HomeSharedCubit>()
                  ..handleHomeSharedIntent(GetAllHomeDataIntent()),
            child: AppSections(initialIndex: initialIndex),
          );
        },
      ),
      GoRoute(
        path: AppRouterPaths.kForgetPasswordView,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<ForgetPasswordCubit>(),
          child: ForgetPasswordScreen(),
        ),
      ),
      GoRoute(
        path: AppRouterPaths.kChangePasswordView,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<ChangePasswordCubit>(),
          child: ChangePasswordView(),
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
        path: AppRouterPaths.kOrdersView,
        builder: (context, state) => BlocProvider.value(
          value: getIt<OrdersCubit>()..handleIntent(FetchOrdersIntent()),
          child: const OrdersView(),
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
          create: (context) => getIt<EditProfileCubit>(),
          child: const EditProfileView(),
        ),
      ),
      GoRoute(
        path: AppRouterPaths.kCheckoutView,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          final double subTotal = args['subTotal'] as double;
          final double deliveryFee = args['deliveryFee'] as double;
          final double total = args['totalPrice'] as double;
          return BlocProvider(
            create: (context) => getIt<CheckoutCubit>(),
            child: CheckoutView(
              subTotal: subTotal,
              deliveryFee: deliveryFee,
              total: total,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRouterPaths.kCreditCardWebView,
        builder: (context, state) {
          final args = state.extra as Map<String, String>;

          return CreditCardWebViewPayment(
            initialUrl: args['initialUrl'] ?? '',
            successUrl: args['successUrl'] ?? '',
            cancelUrl: args['cancelUrl'] ?? '',
          );
        },
      ),
      GoRoute(
        path: AppRouterPaths.kWebView,
        builder: (context, state) {
          final args = state.extra as WebViewArgs;

          return AppWebView(args: args);
        },
      ),
      GoRoute(
        path: AppRouterPaths.kTrackingOrdersMapView,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              getIt<TrackerOrderCubit>()
                ..loadOrderTracking('6a5e03653be1266dec7a5cdd'),
          child: TrackerOrderView(
            args: OrderTrackingArgs(
              orderId: '6a5e03653be1266dec7a5cdd',
              driverName: 'Muhamed',
              estimatedDate: '03 Sep 2024, 11:00 AM',
            ),
          ),
        ),
      ),
      GoRoute(
        path: AppRouterPaths.kTrackingOrderView,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          final orderId = args?['orderId'] as String?;

          return BlocProvider(
            create: (context) {
              final cubit = getIt<OrderTrackingCubit>();
              if (orderId != null) {
                cubit.doIntent(ListenToOrderIntent(orderId));
              }
              return cubit;
            },
            child: TrackingOrderView(orderId: orderId),
          );
        },
      ),
      GoRoute(
        path: AppRouterPaths.kNotificationView,
        builder: (context, state) => const NotificationView(),
      ),
    ],
  );
}
