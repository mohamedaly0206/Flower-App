import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/app_sections/cart/cart_view.dart';
import 'package:flower_app/features/app_sections/categories/presentation/views/categories_view.dart';
import 'package:flower_app/features/app_sections/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home/presentation/view/home_view.dart';

class AppSections extends StatefulWidget {
  const AppSections({super.key});

  @override
  State<AppSections> createState() => _AppSectionsState();
}

class _AppSectionsState extends State<AppSections> {
  int _currentIndex = 0;

  List<_AppSection> get _sections => [
    _AppSection(
      label: AppStrings.home,
      iconPath: Assets.icons.home2Icon,
      screen: HomeView(
        onViewAllCategories: () {
          setState(() => _currentIndex = 1);
        },
      ),
    ),
    _AppSection(
      label: AppStrings.categories,
      iconPath: Assets.icons.categoryIcon,
      screen: const CategoriesView(),
    ),
    _AppSection(
      label: AppStrings.cart,
      iconPath: Assets.icons.shoppingCartIcon,
      screen: const CartView(),
    ),
    _AppSection(
      label: AppStrings.profile,
      iconPath: Assets.icons.personIcon,
      screen: ProfileView(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _sections.map((section) => section.screen).toList(),
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarTheme.of(context).copyWith(
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final color = states.contains(WidgetState.selected)
                ? AppColors.primaryColor
                : AppColors.greyColor;
            return Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: color);
          }),
        ),
        child: NavigationBar(
          height: 56,
          indicatorColor: AppColors.transparentColor,
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() => _currentIndex = index);
          },
          destinations: _sections.map((section) {
            return NavigationDestination(
              icon: _SectionIcon(
                iconPath: section.iconPath,
                color: AppColors.greyColor,
              ),
              selectedIcon: _SectionIcon(
                iconPath: section.iconPath,
                color: AppColors.primaryColor,
              ),
              label: section.label,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _AppSection {
  final String label;
  final String iconPath;
  final Widget screen;

  const _AppSection({
    required this.label,
    required this.iconPath,
    required this.screen,
  });
}

class _SectionIcon extends StatelessWidget {
  final String iconPath;
  final Color color;

  const _SectionIcon({required this.iconPath, required this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      width: 24,
      height: 24,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
