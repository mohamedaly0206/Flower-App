import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onTertiaryFixed,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 96,
            height: 102,
            decoration: BoxDecoration(
              color: Colors.red, // Light Pink Background
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: CachedNetworkImageProvider(
                  'https://m.media-amazon.com/images/I/81OXEQrFPTL._AC_UF1000,1000_QL80_.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Item Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Red roses',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      InkWell(
                        onTap: () {
                          // Handle delete action
                        },
                        child: SvgPicture.asset(
                          Assets.icons.deleteIcon,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.error,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Subtitle
                  Text(
                    '15 Pink Rose Bouquet',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'EGP 600',
                        style: Theme.of(context).textTheme.displayLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          CountItem(
                            onTap: () {},
                            iconPath: Assets.icons.removeIcon,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '1',
                            style: Theme.of(context).textTheme.displayLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 4),
                          CountItem(
                            onTap: () {},
                            iconPath: Assets.icons.addIcon,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CountItem extends StatelessWidget {
  final void Function() onTap;
  final String iconPath;
  const CountItem({required this.onTap, required this.iconPath, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: SvgPicture.asset(
        iconPath,
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onSurface,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
