import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/values/api_endpoints.dart';
import 'package:flower_app/features/occasion/domain/entities/occasion_entity.dart';
import 'package:flutter/material.dart';

class OccasionListViewItem extends StatelessWidget {
  final OccasionEntity occasion;
  final VoidCallback onTap;

  const OccasionListViewItem({
    super.key,
    required this.occasion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final url = '${ApiEndpoints.uploads}/${occasion.image!}';

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              width: 130,
              height: 150,
              fit: BoxFit.cover,
              imageUrl: url,
              errorWidget: (context, error, stackTrace) {
                return Container(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Text(
              occasion.name ?? 'Unknown',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
