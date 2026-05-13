import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Column(
          children: [
            SizedBox(
              height: 56,
              child: TextField(
                controller: searchController,
                onChanged: (value) {},
                autofocus: true,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(Assets.icons.searchIcon, width: 20),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      searchController.clear();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        Assets.icons.cancelIcon,
                        width: 20,
                      ),
                    ),
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
            Expanded(
              child: Center(
                child: Text(
                  AppStrings.searchForAnyProduct,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
