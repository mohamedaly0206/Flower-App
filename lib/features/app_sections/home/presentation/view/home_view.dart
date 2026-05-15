import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/app_sections/home/presentation/widgets/categories_list_view.dart';
import 'package:flower_app/features/app_sections/widgets/custom_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/section_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(width: 5),
                RichText(
                  text: TextSpan(
                    text: AppStrings.deliverTo,
                    style: Theme.of(context).textTheme.headlineMedium!,
                    children: [
                      TextSpan(
                        text: AppStrings.dummyAddress,
                        style: Theme.of(context).textTheme.headlineMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Theme.of(context).primaryColor,
                    size: 35,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            SectionHeader(title: AppStrings.categories, onPressed: () {}),
            const CategoriesListView(),
            const SizedBox(height: 10),
            SectionHeader(title: AppStrings.bestSeller, onPressed: () {}),
            const SizedBox(height: 10),
            SizedBox(
              height: 210,
              child: ListView.separated(
                itemCount: 10,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        width: 130,
                        height: 150,
                        fit: BoxFit.cover,
                        imageUrl:
                            'https://hips.hearstapps.com/hmg-prod/images/gettyimages-2165950545-69600af8c9b0d.jpg?crop=0.667xw:1.00xh;0.112xw,0&resize=1200:*',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Red roses',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        '600 EGP',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
