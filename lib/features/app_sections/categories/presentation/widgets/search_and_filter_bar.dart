import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchAndFilterBar extends StatelessWidget {
  const SearchAndFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    var onTertiaryFixed = Theme.of(context).colorScheme.onTertiaryFixed;
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(Assets.icons.searchIcon, width: 20),
                ),
                hintText: AppStrings.search,
                border: outlineBorder(context),
                enabledBorder: outlineBorder(context),
                focusedBorder: outlineBorder(context),
                errorBorder: outlineBorder(context).copyWith(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: () {},
          child: Container(
            height: 48,
            width: 64,
            decoration: BoxDecoration(
              border: Border.all(color: onTertiaryFixed),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SvgPicture.asset(Assets.icons.sortIcon, width: 20),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder outlineBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.onTertiaryFixed,
      ),
    );
  }
}
