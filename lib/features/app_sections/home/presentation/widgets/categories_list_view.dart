import 'package:flower_app/features/app_sections/home/presentation/widgets/categories_list_view_item.dart';
import 'package:flutter/material.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeSharedCubit, HomeSharedStates>(
      buildWhen: (previous, current) =>
          previous.categoriesState != current.categoriesState,
      builder: (context, state) {
        final categoriesState = state.categoriesState;

        if (categoriesState.isLoading) {
          return SizedBox(
            height: 120,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (categoriesState.errorMessage != null) {
          return SizedBox(
            height: 120,
            child: Center(
              child: Text(
                categoriesState.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        final categoriesList = categoriesState.data?.categories ?? [];

        if (categoriesList.isEmpty) {
          return const SizedBox(
            height: 120,
            child: Center(child: Text("No Categories Found")),
          );
        }

        return SizedBox(
          height: 120,
          child: ListView.separated(
            itemCount: categoriesList.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final category = categoriesList[index];
              return CategoriesListViewItem(category: category);
            },
          ),
        );
      },
    );
  }
}
