import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/shared_features/shared_view_model/Intent/home_shared_intent.dart';
import 'package:flower_app/core/shared_features/shared_view_model/cubit/home_shared_cubit.dart';
import 'package:flower_app/core/shared_features/shared_view_model/states/home_shared_states.dart';
import 'package:flower_app/core/widgets/custom_product_card.dart';
import 'package:flower_app/core/widgets/custom_tab_bar.dart';
import 'package:flower_app/features/app_sections/categories/presentation/widgets/search_and_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<HomeSharedCubit>()
            ..handleHomeSharedIntent(GetCategoriesIntent()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SearchAndFilterBar(),
              const SizedBox(height: 16),
              BlocBuilder<HomeSharedCubit, HomeSharedStates>(
                builder: (context, state) {
                  return CustomTabBar(
                    tabs:
                        state.categoriesState.data?.categories
                            .map((e) => e.name)
                            .toList() ??
                        [],
                    selectedIndex: state.selectedIndex,
                    onTabSelected: (index) {
                      context.read<HomeSharedCubit>().handleHomeSharedIntent(
                        ChangeTabIntent(index),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 28),
              BlocBuilder<HomeSharedCubit, HomeSharedStates>(
                builder: (context, state) {
                  final products = state.productsState.data?.products ?? [];
                  return Expanded(
                    child: state.productsState.isLoading
                        ? Center(
                            child: SpinKitFadingCircle(
                              color: Theme.of(context).colorScheme.primary,
                              size: 50,
                            ),
                          )
                        : products.isEmpty
                        ? Center(
                            child: Text(
                              'No products found in this category',
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                          )
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      MediaQuery.of(context).size.width > 600
                                      ? 3
                                      : 2,
                                  mainAxisSpacing: 18,
                                  crossAxisSpacing: 18,
                                  childAspectRatio: 0.72,
                                ),
                            itemBuilder: (context, index) {
                              final product =
                                  state.productsState.data?.products?[index];
                              return CustomProductCard(
                                title: product?.title ?? 'Product Title',
                                imageProvider: CachedNetworkImageProvider(
                                  product?.imageCover ?? '',
                                ),
                                price: product?.price ?? 6000,

                                oldPrice: product?.priceAfterDiscount ?? 9000,
                                discountPercent: product?.discount ?? 0,
                                onAddToCart: () {},
                                onTap: () {},
                              );
                            },
                            shrinkWrap: true,
                            itemCount:
                                state.productsState.data?.products?.length ?? 0,
                            scrollDirection: Axis.vertical,
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
