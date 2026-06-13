import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AddAddressView extends StatelessWidget {
  const AddAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.addNewAddress),
      body: const Center(
        child: Text(AppStrings.addNewAddress),
      ),
    );
  }
}
