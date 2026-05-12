import 'package:flower_app/core/widgets/custom_product_card.dart';
import 'package:flower_app/features/app_sections/categories/presentation/widgets/category_tab.dart';
import 'package:flower_app/features/app_sections/categories/presentation/widgets/search_and_filter_bar.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SearchAndFilterBar(),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return const CategoryTab(
                    isSelected: true,
                    categoryName: 'All',
                  );
                },
                shrinkWrap: true,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
              ),
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
    );
  }
}
