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
          ],
        ),
      ),
    );
  }
}

