import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/features/orders/domain/models/orders_model.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItemCard extends StatelessWidget {
  final OrdersModel order;
  final bool isActive;

  const OrderItemCard({super.key, required this.order, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final title = order.productTitle?.trim().isNotEmpty == true
        ? order.productTitle!
        : AppLocalizations.of(context)!.myOrders;

    return Container(
      height: 125,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.placeHolderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl:
                  order.productImage ??
                  "https://imgs.search.brave.com/iZkFC-cgkxOzKo8z-nVJdD67At_hFBSca7wvu0Ugqks/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTAy/Nzk4NzgwNC92ZWN0/b3IvZXJyb3ItbWVz/c2FnZS5qcGc_cz02/MTJ4NjEyJnc9MCZr/PTIwJmM9RnozQWRR/OFhtdlVkM1d2eHdU/RHk3OFVnQlk0ODhj/UTdQdFpTaVctRTVs/ND0",
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.local_florist_outlined,
                color: AppColors.primaryColor,
                size: 34,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.textStyleRegular12.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'EGP ${order.totalPrice ?? 0}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.textStyleMedium14.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isActive ? _orderNumberText : _deliveredText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.textStyleRegular12.copyWith(
                    color: AppColors.greyColor,
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        isActive
                            ? AppLocalizations.of(context)!.trackOrder
                            : AppLocalizations.of(context)!.reorder,
                        style: AppTextStyles.textStyleMedium12.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('d MMM yyyy').format(date);
  }

  String get _orderNumberText {
    final number = order.orderNumber?.trim();
    return number == null || number.isEmpty
        ? 'Order number unavailable'
        : 'Order number $number';
  }

  String get _deliveredText {
    final date = _formatDate(order.updatedAt ?? order.createdAt);
    return date.isEmpty ? 'Delivered' : 'Delivered on $date';
  }
}
