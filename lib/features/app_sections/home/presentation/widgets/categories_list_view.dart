import 'package:flower_app/features/app_sections/home/presentation/widgets/categories_list_view_item.dart';
import 'package:flutter/material.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        itemCount: 10,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return CategoriesListViewItem();
        },
      ),
    );
  }
}
