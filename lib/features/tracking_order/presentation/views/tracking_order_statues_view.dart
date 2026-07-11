import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/tracking_order/presentation/view_model/cubit/order_tracking_cubit.dart';
import 'package:flower_app/features/tracking_order/presentation/view_model/intent/order_tracking_intent.dart';
import 'package:flower_app/features/tracking_order/presentation/widgets/arrival_estimate_widget.dart';
import 'package:flower_app/features/tracking_order/presentation/widgets/delivery_hero_widget.dart';
import 'package:flower_app/features/tracking_order/presentation/widgets/order_actions_widget.dart';
import 'package:flower_app/features/tracking_order/presentation/widgets/order_timeline_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrackingOrderStatuesView extends StatelessWidget {
  const TrackingOrderStatuesView({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderTrackingCubit, OrderTrackingState>(
      builder: (context, state) {
        final order = state.trackOrderState?.data;
        if (order == null) return const SizedBox.shrink();

        final currentStep = state.currentStep;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ArrivalEstimateWidget(),
              const SizedBox(height: 24),
              DeliveryHeroWidget(driverName: order.driverName ?? 'Driver'),
              const SizedBox(height: 24),
              Center(child: SvgPicture.asset(Assets.icons.car, height: 100)),
              const SizedBox(height: 24),
              OrderTimelineWidget(currentStep: currentStep),
              const SizedBox(height: 32),
              OrderActionsWidget(
                status: order.status,
                onOrderDelivered: () {
                  context.read<OrderTrackingCubit>().doIntent(
                    MarkOrderCompletedIntent(order.orderId),
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}
