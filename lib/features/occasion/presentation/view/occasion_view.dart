import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/product_entity.dart';
import 'package:flower_app/core/shared_features/shared_view_model/cubit/home_shared_cubit.dart';
import 'package:flower_app/core/shared_features/shared_view_model/Intent/home_shared_intent.dart';
import 'package:flower_app/core/shared_features/shared_view_model/states/home_shared_states.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';

import 'package:flower_app/core/widgets/app_loading.dart';
import 'package:flower_app/core/widgets/app_messages.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/core/widgets/custom_product_card.dart';
import 'package:flower_app/core/widgets/custom_tab_bar.dart';
import 'package:flower_app/features/occasion/domain/entities/occasion_entity.dart';
import 'package:flower_app/features/occasion/presentation/view_model/intent/occasion_intent.dart';
import 'package:flower_app/features/occasion/presentation/view_model/state/occasion_state.dart';
import 'package:flower_app/features/occasion/presentation/view_model/cubit/occasion_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';

class OccasionView extends StatelessWidget {
  const OccasionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OccasionCubit, OccasionState>(
      listener: _occasionListener,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CustomAppBar(title: AppLocalizations.of(context)!.occasion),
        body: BlocBuilder<OccasionCubit, OccasionState>(
          builder: (context, state) {
            if (state.status == OccasionStatus.loading ||
                state.status == OccasionStatus.initial) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }

            if (state.status == OccasionStatus.failure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.errorColor,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.errorMessage ?? '',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.textStyleRegular14.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<OccasionCubit>().handleIntent(
                              const LoadOccasionsIntent(),
                            ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state.status == OccasionStatus.success) {
              return _OccasionContent(
                occasions: state.occasions,
                selectedTabIndex: state.selectedTabIndex,
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _occasionListener(BuildContext context, OccasionState state) {
    AppLoading.toggle(context: context, isLoading: false);

    if (state.status == OccasionStatus.success) {
      if (state.occasions.isNotEmpty &&
          state.selectedTabIndex < state.occasions.length) {
        final occasion = state.occasions[state.selectedTabIndex];

        if (occasion.id != null) {
          context.read<HomeSharedCubit>().handleHomeSharedIntent(
            GetProductsIntent(occasionId: occasion.id),
          );
        }
      }
    }

    if (state.status == OccasionStatus.failure && state.errorMessage != null) {
      AppMessages.showError(context, message: state.errorMessage!);
    }
  }
}

class _OccasionContent extends StatelessWidget {
  final List<OccasionEntity> occasions;
  final int selectedTabIndex;

  const _OccasionContent({
    required this.occasions,
    required this.selectedTabIndex,
  });

  @override
  Widget build(BuildContext context) {
    if (occasions.isEmpty) {
      return Center(
        child: Text(
          'No occasions available',
          style: AppTextStyles.textStyleRegular14.copyWith(
            color: AppColors.greyColor,
          ),
        ),
      );
    }

    final tabNames = occasions.map((o) => o.name ?? '').toList();
    final selectedOccasion = occasions[selectedTabIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Text(
            AppLocalizations.of(context)!.bloomWithBestSellers,
            style: AppTextStyles.textStyleRegular13.copyWith(
              color: AppColors.greyColor,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomTabBar(
            tabs: tabNames,
            selectedIndex: selectedTabIndex,
            onTabSelected: (index) {
              context.read<OccasionCubit>().handleIntent(
                SelectTabIntent(index),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Expanded(child: _OccasionProductGrid(occasion: selectedOccasion)),
      ],
    );
  }
}

class _OccasionProductGrid extends StatelessWidget {
  final OccasionEntity occasion;

  const _OccasionProductGrid({required this.occasion});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeSharedCubit, HomeSharedStates>(
      buildWhen: (previous, current) =>
          previous.productsState != current.productsState,
      builder: (context, state) {
        if (state.productsState.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }

        if (state.productsState.errorMessage != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.errorColor,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.productsState.errorMessage!,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.textStyleRegular14.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (occasion.id != null) {
                        context.read<HomeSharedCubit>().handleHomeSharedIntent(
                          GetProductsIntent(occasionId: occasion.id),
                        );
                      }
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state.productsState.data != null) {
          final products = state.productsState.data!.products ?? [];

          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.local_florist_outlined,
                    color: AppColors.placeHolderColor,
                    size: 56,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No products in this occasion yet',
                    style: AppTextStyles.textStyleRegular14.copyWith(
                      color: AppColors.placeHolderColor,
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return _ProductCard(product: product);
              },
            ),
          );
        }

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.local_florist_outlined,
                color: AppColors.placeHolderColor,
                size: 56,
              ),
              const SizedBox(height: 12),
              Text(
                'Select an occasion to see products',
                style: AppTextStyles.textStyleRegular14.copyWith(
                  color: AppColors.placeHolderColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductEntity product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.imageCover ?? '';
    int? discountPercent;

    if (product.priceAfterDiscount != null &&
        product.price != null &&
        product.price! > 0) {
      final pct =
          ((product.price! - product.priceAfterDiscount!) / product.price!) *
          100;
      discountPercent = pct.round();
    }

    return CustomProductCard(
      title: product.title ?? '',
      imageProvider: CachedNetworkImageProvider(imageUrl),
      price: product.priceAfterDiscount ?? product.price ?? 0,
      oldPrice: product.priceAfterDiscount != null ? product.price : null,
      discountPercent: discountPercent,
      onTap: () {
        GoRouter.of(
          context,
        ).push(AppRouterPaths.kProductDetailsView, extra: product);
      },
      onAddToCart: () {},
    );
  }
}
