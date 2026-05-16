import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/features/occasion/domain/entities/occasion_entity.dart';
import 'package:flutter/material.dart';


class OccasionListViewItem extends StatelessWidget {
  const OccasionListViewItem({
    super.key,
    required this.occasion,
  });

  final OccasionEntity occasion;

  @override
  Widget build(BuildContext context) {
    final url = occasion.image;
    print(url);
    return SizedBox(
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            width: 130,
            height: 150,
            fit: BoxFit.cover,
            imageUrl: url ??'',
          ),

          const SizedBox(height: 8),

          Text(
            occasion.name ?? 'Unknown',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}