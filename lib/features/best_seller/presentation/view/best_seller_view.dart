import 'package:flower_app/core/shared_features/shared_view_model/cubit/home_shared_cubit.dart';
import 'package:flower_app/core/shared_features/shared_view_model/states/home_shared_states.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';

import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/features/best_seller/presentation/widgets/custom_best_seller_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../l10n/app_localizations.dart';

class BestSellerView extends StatelessWidget {
  const BestSellerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.bestSeller),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.bloomWithBestSellers,
              style: AppTextStyles.textStyleMedium13,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<HomeSharedCubit, HomeSharedStates>(
                builder: (context, state) {
                  final bestSellersState = state.bestSellersState;

                  if (bestSellersState.isLoading) {
                    return Center(
                      child: SpinKitFadingCircle(
                        color: Theme.of(context).colorScheme.primary,
                        size: 50,
                      ),
                    );
                  }

                  if (bestSellersState.errorMessage != null) {
                    return Center(child: Text(bestSellersState.errorMessage!));
                  }

                  final bestSellers = bestSellersState.data!.products ?? [];

                  if (bestSellers.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.noProductsFound,
                      ),
                    );
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
