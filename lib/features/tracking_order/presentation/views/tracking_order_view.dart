import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/features/tracking_order/presentation/view_model/cubit/order_tracking_cubit.dart';
import 'package:flower_app/features/tracking_order/presentation/view_model/intent/order_tracking_intent.dart';
import 'package:flower_app/features/tracking_order/presentation/views/success_placed_order_view.dart';
import 'package:flower_app/features/tracking_order/presentation/views/tracking_order_statues_view.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackingOrderView extends StatefulWidget {
  const TrackingOrderView({super.key, this.orderId});
  final String? orderId;

  @override
  State<TrackingOrderView> createState() => _TrackingOrderViewState();
}

class _TrackingOrderViewState extends State<TrackingOrderView> {
  final PageController pageController = PageController();

  final List<String> _trackingStatuses = [
    'accepted',
    'picked',
    'outForDelivery',
    'arrived',
    'delivered',
    'completed',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.orderId != null) {
      context.read<OrderTrackingCubit>().doIntent(
        ListenToOrderIntent(widget.orderId!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.trackOrder),
      body: BlocConsumer<OrderTrackingCubit, OrderTrackingState>(
        listener: (context, state) {
          final order = state.trackOrderState?.data;
          if (order != null) {
            if (_trackingStatuses.contains(order.status)) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (pageController.hasClients &&
                    pageController.page?.round() != 1) {
                  pageController.jumpToPage(1);
                }
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (pageController.hasClients &&
                    pageController.page?.round() != 0) {
                  pageController.jumpToPage(0);
                }
              });
            }
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (pageController.hasClients &&
                  pageController.page?.round() != 0) {
                pageController.jumpToPage(0);
              }
            });
          }
        },
        builder: (context, state) {
          final isLoading = state.trackOrderState?.isLoading ?? false;
          if (isLoading && state.trackOrderState?.data == null) {
            return const Center(child: CircularProgressIndicator());
          } 

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SuccessPlacedOrderView(controller: pageController),
                if (state.trackOrderState?.data != null)
                  TrackingOrderStatuesView(controller: pageController)
                else
                  const SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}
