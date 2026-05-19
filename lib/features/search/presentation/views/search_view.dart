import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/shared_features/shared_view_model/Intent/home_shared_intent.dart';
import 'package:flower_app/core/shared_features/shared_view_model/cubit/home_shared_cubit.dart';
import 'package:flower_app/core/shared_features/shared_view_model/states/home_shared_states.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/core/widgets/custom_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../l10n/app_localizations.dart';

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
                onChanged: (value) {
                  context.read<HomeSharedCubit>().handleHomeSharedIntent(
                    SearchIntent(value),
                  );
                },
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
                  hintText: AppLocalizations.of(context)!.search,
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
            BlocBuilder<HomeSharedCubit, HomeSharedStates>(
              builder: (context, state) {
                final products = state.productsState.data?.products ?? [];
                return Expanded(
                  child: state.productsState.isLoading
                      ? Center(
                          child: SpinKitFadingCircle(
                            color: Theme.of(context).colorScheme.primary,
                            size: 50,
                          ),
                        )
                      : products.isEmpty
                      ? Center(
                          child: Text(
                            searchController.text.trim().isEmpty
                                ? AppLocalizations.of(context)!.searchForAnyProduct
                                : AppLocalizations.of(context)!.noProductsFound,
                            style: Theme.of(context).textTheme.displayLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    MediaQuery.of(context).size.width > 600
                                    ? 3
                                    : 2,
                                mainAxisSpacing: 18,
                                crossAxisSpacing: 18,
                                childAspectRatio: 0.72,
                              ),
                          itemBuilder: (context, index) {
                            final product =
                                state.productsState.data?.products?[index];
                            return CustomProductCard(
                              title: product?.title ?? 'Product Title',
                              imageProvider: CachedNetworkImageProvider(
                                product?.imageCover ?? '',
                              ),
                              price: product?.price ?? 6000,

                              oldPrice: product?.priceAfterDiscount ?? 9000,
                              discountPercent: product?.discount ?? 0,
                              onAddToCart: () {},
                              onTap: () {},
                            );
                          },
                          shrinkWrap: true,
                          itemCount:
                              state.productsState.data?.products?.length ?? 0,
                          scrollDirection: Axis.vertical,
                        ),
                );
              },
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
