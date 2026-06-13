import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/app_loading.dart';
import 'package:flower_app/core/widgets/app_messages.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/features/user_addresses/domain/entities/user_addresses_entity.dart';
import 'package:flower_app/features/user_addresses/presentation/utils/address_localization.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/cubit/user_addresses_cubit.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/intent/user_addresses_intent.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/state/user_addresses_state.dart';
import 'package:flower_app/features/user_addresses/presentation/widgets/address_form.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressFormView extends StatefulWidget {
  final AddressEntity? address;

  const AddressFormView({super.key, this.address});

  bool get isEditMode => address != null;

  @override
  State<AddressFormView> createState() => _AddressFormViewState();
}

class _AddressFormViewState extends State<AddressFormView> {
  late final TextEditingController _streetController;
  late final TextEditingController _phoneController;
  late final TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    final address = widget.address;

    _streetController = TextEditingController(text: address?.street ?? '');
    _phoneController = TextEditingController(text: address?.phone ?? '');
    _usernameController = TextEditingController(text: address?.username ?? '');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final cubit = context.read<UserAddressesCubit>();
      cubit.handleIntent(const LoadEgyptLocationsIntent());
      _syncControllersFromState();
    });
  }

  void _syncControllersFromState() {
    final formState = context.read<UserAddressesCubit>().state;
    _streetController.text = formState.street;
    _phoneController.text = formState.phone;
    _usernameController.text = formState.username;
  }

  @override
  void dispose() {
    AppLoading.toggle(context: context, isLoading: false);
    _streetController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocListener<UserAddressesCubit, UserAddressesState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.successMessage != current.successMessage ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        AppLoading.toggle(
          context: context,
          isLoading: state.status == UserAddressesStatus.saving,
        );

        if (state.status == UserAddressesStatus.error &&
            state.errorMessage != null) {
          AppMessages.showError(
            context,
            message: localizeAddressMessage(context, state.errorMessage),
          );
        }

        if (state.status == UserAddressesStatus.success &&
            state.successMessage != null) {
          AppMessages.showSuccess(
            context,
            message: localizeAddressMessage(context, state.successMessage),
          );
          Navigator.of(context).pop(true);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CustomAppBar(
          title: widget.isEditMode ? loc.editAddress : loc.addAddress,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: AddressForm(
            streetController: _streetController,
            phoneController: _phoneController,
            usernameController: _usernameController,
          ),
        ),
      ),
    );
  }
}
