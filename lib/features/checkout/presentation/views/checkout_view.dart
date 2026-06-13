import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentation/view_model/state/checkout_state.dart';
import 'package:flower_app/features/checkout/presentation/widgets/delivery_address_widget.dart';
import 'package:flower_app/features/checkout/presentation/widgets/delivery_time_widget.dart';
import 'package:flower_app/features/checkout/presentation/widgets/divider_widget.dart';
import 'package:flower_app/features/checkout/presentation/widgets/gift_widget.dart';
import 'package:flower_app/features/checkout/presentation/widgets/payment_methods_card.dart';
import 'package:flower_app/features/checkout/presentation/widgets/prices_checkout_widget.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutView extends StatelessWidget {
  final double subTotal;
  final double deliveryFee;
  final double total;
  final _giftFormKey = GlobalKey<FormState>();
  final _giftNameController = TextEditingController();
  final _giftPhoneController = TextEditingController();

  CheckoutView({
    super.key,
    required this.subTotal,
    required this.deliveryFee,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.checkout,
        hasBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DeliveryTimeWidget(),
            const SizedBox(height: 24),
            const DividerWidget(),
            const SizedBox(height: 24),
            const DeliveryAddressWidget(),
            const SizedBox(height: 24),
            const DividerWidget(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                appLocalizations!.paymentMethod,
                style: theme.textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 16),
            // Payment Method Section
            BlocBuilder<CheckoutCubit, CheckoutState>(
              builder: (context, state) {
                return Column(
                  children: [
                    PaymentMethodsCard(
                      method: PaymentMethod.cashOnDelivery,
                      title: appLocalizations.cashOnDelivery,
                      state:
                          state.selectedPaymentMethod ==
                              PaymentMethod.cashOnDelivery
                          ? state
                          : CheckoutState(),
                    ),
                    const SizedBox(height: 8),
                    PaymentMethodsCard(
                      method: PaymentMethod.creditCard,
                      title: appLocalizations.creditCard,
                      state:
                          state.selectedPaymentMethod ==
                              PaymentMethod.creditCard
                          ? state
                          : CheckoutState(),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            const DividerWidget(),

            // Gift Section
            GiftWidget(
              formKey: _giftFormKey,
              nameController: _giftNameController,
              phoneController: _giftPhoneController,
            ),
            const DividerWidget(),
            const SizedBox(height: 24),
            PricesCheckoutWidget(
              subTotal: subTotal,
              deliveryFee: deliveryFee,
              total: total,
              giftFormKey: _giftFormKey,
            ),

            // Price Summary
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
