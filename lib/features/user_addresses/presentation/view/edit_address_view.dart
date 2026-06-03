import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/features/user_addresses/domain/entities/user_addresses_entity.dart';
import 'package:flutter/material.dart';

class EditAddressView extends StatelessWidget {
  final AddressEntity address;

  const EditAddressView({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.saveAddress),
      body: Center(
        child: Text(
          '${address.city ?? ''}\n${address.street ?? ''}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
