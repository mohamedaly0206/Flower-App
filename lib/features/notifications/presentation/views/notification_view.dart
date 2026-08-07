import 'dart:developer';

import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/features/notifications/presentation/view_model/cubit/notifications_cubit.dart';
import 'package:flower_app/features/notifications/presentation/view_model/intent/notifications_intent.dart';
import 'package:flower_app/features/notifications/presentation/view_model/state/notifications_states.dart';
import 'package:flower_app/features/notifications/presentation/widgets/notification_card.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) =>
          getIt<NotificationsCubit>()
            ..handleIntent(const FetchNotificationsIntent()),
      child: Scaffold(
        appBar: CustomAppBar(title: AppLocalizations.of(context)!.notification),
        body: BlocBuilder<NotificationsCubit, NotificationsStates>(
          builder: (context, state) {
            if (state.getNotificationsState.isLoading) {
              return Center(
                child: SpinKitFadingCircle(
                  color: theme.colorScheme.primary,
                  size: 50.0,
                ),
              );
            } else if (state.getNotificationsState.errorMessage != null) {
              log('Error: ${state.getNotificationsState.errorMessage}');
              return Center(
                child: Text(state.getNotificationsState.errorMessage!),
              );
            } else if (state.getNotificationsState.data != null &&
                state.getNotificationsState.isLoading == false) {
              final notifications = state.getNotificationsState.data!;
              log('Notifications: ${notifications.length}');
              if (notifications.isEmpty) {
                return const Center(
                  child: Text(AppStrings.noNotificationsFound),
                );
              }
              return ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final item = notifications[index];
                  return NotificationItem(
                    title: item.title,
                    description: item.body,
                    createdAt: item.createdAt,
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
