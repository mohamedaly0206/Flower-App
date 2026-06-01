import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/features/orders/domain/models/orders_model.dart';
import 'package:flower_app/features/orders/presentation/view_model/cubit/orders_cubit.dart';
import 'package:flower_app/features/orders/presentation/view_model/state/orders_status.dart';
import 'package:flower_app/features/orders/presentation/widgets/custom_order_item_card.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CustomAppBar(title: AppLocalizations.of(context)!.myOrders),
        body: Column(
          children: [
            const TabBar(
              indicatorColor: AppColors.primaryColor,
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: AppColors.placeHolderColor,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(text: 'Active'),
                Tab(text: 'Completed'),
              ],
            ),
            Expanded(
              child: BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, state) {
                  if (state.status == OrdersStatus.loading) {
                    return Center(
                      child: SpinKitFadingCircle(
                        color: Theme.of(context).colorScheme.primary,
                        size: 50,
                      ),
                    );
                  }

                  if (state.status == OrdersStatus.error) {
                    return Center(
                      child: Text(state.errorMessage ?? 'Something went wrong'),
                    );
                  }

                  return TabBarView(
                    children: [
                      _OrdersList(
                        orders: state.activeOrders,
                        isActive: true,
                        emptyMessage: 'No active orders found',
                      ),
                      _OrdersList(
                        orders: state.completedOrders,
                        isActive: false,
                        emptyMessage: 'No completed orders found',
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrdersList extends StatelessWidget {
  final List<OrdersModel> orders;
  final bool isActive;
  final String emptyMessage;

  const _OrdersList({
    required this.orders,
    required this.isActive,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(child: Text(emptyMessage));
    }

    return ListView.builder(
      itemCount: orders.length,
      padding: const EdgeInsets.only(top: 8),
      itemBuilder: (context, index) {
        return OrderItemCard(order: orders[index], isActive: isActive);
      },
    );
  }
}
