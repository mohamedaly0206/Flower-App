import 'package:flower_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        const SizedBox(width: 5),
        RichText(
          text: TextSpan(
            text: AppStrings.deliverTo,
            style: Theme.of(context).textTheme.headlineMedium,
            children: [
              TextSpan(
                text: AppStrings.dummyAddress,
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
    );
  }
}
