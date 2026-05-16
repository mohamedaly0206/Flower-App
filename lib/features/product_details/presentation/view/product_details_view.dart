import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/product_entity.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailsView({super.key, required this.product});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final PageController _pageController = PageController();
  late final List<String> _allImages;

  @override
  void initState() {
    super.initState();
    _allImages = [
      if (widget.product.imageCover != null) widget.product.imageCover!,
      ...(widget.product.images ?? []),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          width: double.infinity,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: _allImages.length,
                            itemBuilder: (context, index) {
                              return CachedNetworkImage(
                                imageUrl: _allImages[index],
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          top: 16,
                          left: 16,
                          child: IconButton(
                            tooltip: "Back",
                            onPressed: () => context.pop(),
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        if (_allImages.length > 1)
                          Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: SmoothPageIndicator(
                                controller: _pageController,
                                count: _allImages.length,
                                effect: const ExpandingDotsEffect(
                                  dotHeight: 8,
                                  dotWidth: 8,
                                  activeDotColor: AppColors.primaryColor,
                                  dotColor: AppColors.placeHolderColor,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${AppStrings.egp} ${widget.product.priceAfterDiscount ?? widget.product.price}',
                                style: AppTextStyles.textStyleSemiBold20,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: AppTextStyles.textStyleRegular14
                                      .copyWith(color: AppColors.blackColor),
                                  children: [
                                    const TextSpan(
                                      text: '${AppStrings.status}: ',
                                    ),
                                    TextSpan(
                                      text: (widget.product.quantity ?? 0) > 0
                                          ? AppStrings.inStock
                                          : AppStrings.outOfStock,
                                      style: AppTextStyles.textStyleRegular14,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppStrings.pricesIncludedTax,
                            style: AppTextStyles.textStyleRegular12.copyWith(
                              color: AppColors.placeHolderColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.product.title ?? '',
                            style: AppTextStyles.textStyleMedium18,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            AppStrings.description,
                            style: AppTextStyles.textStyleSemiBold12.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.product.description ?? '',
                            style: AppTextStyles.textStyleRegular14.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    AppStrings.addToCart,
                    style: AppTextStyles.textStyleMedium16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
