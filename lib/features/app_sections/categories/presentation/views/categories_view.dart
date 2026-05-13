import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/shared_features/Intent/home_shared_intent.dart';
import 'package:flower_app/core/shared_features/cubit/home_shared_cubit.dart';
import 'package:flower_app/core/shared_features/states/home_shared_states.dart';
import 'package:flower_app/core/widgets/custom_product_card.dart';
import 'package:flower_app/core/widgets/custom_tab_bar.dart';
import 'package:flower_app/features/app_sections/categories/presentation/widgets/search_and_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<HomeSharedCubit>()..handleHomeSharedIntent(GetCategoriesIntent()),
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
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600
                        ? 3
                        : 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    return CustomProductCard(
                      title: 'fuchsia-brilliance-vase',
                      imageProvider: CachedNetworkImageProvider(
                        'https://cdn1.1800flowers.com/wcsstore/Flowers/images/catalog/191167xlx.jpg?height=755&width=690?auto=webp',
                      ),
                      price: 6000,
                      oldPrice: 9000,
                      discountPercent: 33,
                      onAddToCart: () {},
                      onTap: () {},
                    );
                  },
                  shrinkWrap: true,
                  itemCount: 10,
                  scrollDirection: Axis.vertical,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
