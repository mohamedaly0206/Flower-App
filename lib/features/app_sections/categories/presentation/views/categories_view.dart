import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/shared_features/Intent/home_shared_intent.dart';
import 'package:flower_app/core/shared_features/cubit/home_shared_cubit.dart';
import 'package:flower_app/core/shared_features/states/home_shared_states.dart';
import 'package:flower_app/core/widgets/custom_product_card.dart';
import 'package:flower_app/features/app_sections/categories/presentation/widgets/category_tab.dart';
import 'package:flower_app/features/app_sections/categories/presentation/widgets/search_and_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  return SizedBox(
                    height: 40,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return CategoryTab(
                          isSelected: true,
                          categoryName: state.categoriesState.data?.categories[index].name ?? '',
                        );
                      },
                      shrinkWrap: true,
                      itemCount: state.categoriesState.data?.categories.length ?? 0,
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                },
              ),
              SizedBox(height: 28),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    return CustomProductCard();
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
