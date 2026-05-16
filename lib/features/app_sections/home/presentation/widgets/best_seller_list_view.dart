import 'package:flower_app/core/shared_features/shared_view_model/cubit/home_shared_cubit.dart';
import 'package:flower_app/core/shared_features/shared_view_model/states/home_shared_states.dart';
import 'package:flower_app/features/app_sections/home/presentation/widgets/best_seller_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellerListView extends StatelessWidget {
  const BestSellerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeSharedCubit, HomeSharedStates>(
      buildWhen: (previous, current) =>
      previous.bestSellersState != current.bestSellersState,
      builder: (context, state) {
        final bestSellerState = state.bestSellersState;

        // loading
        if (bestSellerState.isLoading) {
          return const SizedBox(
            height: 210,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // error
        if (bestSellerState.errorMessage != null) {
          return SizedBox(
            height: 210,
            child: Center(
              child: Text(
                bestSellerState.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        // data
        final bestSellers = bestSellerState.data ?? [];

        // empty
        if (bestSellers.isEmpty) {
          return const SizedBox(
            height: 210,
            child: Center(
              child: Text('No Best Sellers Found'),
            ),
          );
        }

        return SizedBox(
          height: 210,
          child: ListView.separated(
            itemCount: bestSellers.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) =>
            const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final bestSeller = bestSellers[index];

              return BestSellerListViewItem(
                bestSeller: bestSeller,
              );
            },
          ),
        );
      },
    );
  }
}