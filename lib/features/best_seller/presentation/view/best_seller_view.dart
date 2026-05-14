import 'package:flower_app/core/shared_features/cubit/home_shared_cubit.dart';
import 'package:flower_app/core/shared_features/states/home_shared_states.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/features/best_seller/presentation/widgets/custom_best_seller_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellerView extends StatelessWidget {
  const BestSellerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.bestSeller),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.bloomWithBestSellers,
              style: AppTextStyles.textStyleMedium13,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<HomeSharedCubit, HomeSharedStates>(
                builder: (context, state) {
                  final bestSellersState = state.bestSellersState;

                  if (bestSellersState.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (bestSellersState.errorMessage != null) {
                    return Center(child: Text(bestSellersState.errorMessage!));
                  }

                  final bestSellers = bestSellersState.data ?? [];

                  if (bestSellers.isEmpty) {
                    return const Center(child: Text('No Products Found'));
                  }

                  return CustomBestSellerGrid(bestSellers: bestSellers);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
