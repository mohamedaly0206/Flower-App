import 'package:flower_app/core/router/router_paths.dart';
 
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/core/widgets/address_widget.dart';
import 'package:flower_app/features/app_sections/home/presentation/widgets/best_seller_list_view.dart';
import 'package:flower_app/features/app_sections/home/presentation/widgets/categories_list_view.dart';
import 'package:flower_app/features/app_sections/widgets/custom_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../l10n/app_localizations.dart';
import '../widgets/occasion_list_view.dart';
import '../widgets/section_header.dart';

class HomeView extends StatelessWidget {
  final VoidCallback onViewAllCategories;

  const HomeView({super.key, required this.onViewAllCategories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(child: SvgPicture.asset(Assets.icons.logo)),
                      const SizedBox(width: 17),
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () {
                            GoRouter.of(
                              context,
                            ).push(AppRouterPaths.kSearchView);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: IgnorePointer(
                            child: CustomSearchTextField(
                              hintText: AppLocalizations.of(context)!.search,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
<<<<<<< HEAD
                const AddressWidget(),
=======
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(width: 5),
                    RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context)!.deliverTo,
                        style: Theme.of(context).textTheme.headlineMedium,
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.dummyAddress,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Theme.of(context).primaryColor,
                        size: 35,
                      ),
                    ),
                  ],
                ),
>>>>>>> d9976f87fceac775736c77f2cda79ba2e1f64e00
                const SizedBox(height: 5),
                SectionHeader(
                  title: AppLocalizations.of(context)!.categories,
                  onPressed: onViewAllCategories,
                ),
                CategoriesListView(onCategorySelected: onViewAllCategories),
                const SizedBox(height: 10),
                SectionHeader(
                  title: AppLocalizations.of(context)!.bestSeller,
                  onPressed: () {
                    GoRouter.of(context).push(AppRouterPaths.kBestSellerView);
                  },
                ),
                const SizedBox(height: 10),
                const BestSellerListView(),
                const SizedBox(height: 10),
                SectionHeader(
                  title: AppLocalizations.of(context)!.occasion,
                  onPressed: () {
                    GoRouter.of(context).push(AppRouterPaths.kOccasionView);
                  },
                ),
                const SizedBox(height: 10),
                OccasionListView(
                  onOccasionSelected: (index) {
                    GoRouter.of(
                      context,
                    ).push(AppRouterPaths.kOccasionView, extra: index);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
