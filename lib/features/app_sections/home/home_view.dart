import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/app_sections/widgets/custom_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: Row(
                spacing: 17,
                children: [
                  Expanded(child: SvgPicture.asset(Assets.icons.logo)),
                  Expanded(
                    flex: 3,
                    child: CustomSearchTextField(
                      hintText: AppStrings.search,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () =>
                    GoRouter.of(context).push(AppRouterPaths.kOccasionView),
                icon: const Icon(Icons.local_florist_outlined),
                label: Text(AppStrings.occasion),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
