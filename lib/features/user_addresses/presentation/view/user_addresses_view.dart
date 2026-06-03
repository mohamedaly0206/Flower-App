import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/widgets/app_loading.dart';
import 'package:flower_app/core/widgets/app_messages.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/features/user_addresses/domain/entities/user_addresses_entity.dart';
import 'package:flower_app/features/user_addresses/presentation/view/add_address_view.dart';
import 'package:flower_app/features/user_addresses/presentation/view/edit_address_view.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/cubit/user_addresses_cubit.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/intent/user_addresses_intent.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/state/user_addresses_state.dart';
import 'package:flower_app/features/user_addresses/presentation/widgets/user_address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAddressesView extends StatefulWidget {
  const UserAddressesView({super.key});

  @override
  State<UserAddressesView> createState() => _UserAddressesViewState();
}

class _UserAddressesViewState extends State<UserAddressesView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserAddressesCubit>().handleIntent(
        const FetchUserAddressesIntent(),
      );
    });
  }

  void _openAddAddress() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const AddAddressView()),
    );
  }

  void _openEditAddress(AddressEntity address) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => EditAddressView(address: address),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserAddressesCubit, UserAddressesState>(
      listener: (context, state) {
        final isBusy = state.status == UserAddressesStatus.loading ||
            state.status == UserAddressesStatus.deleting;
        AppLoading.toggle(context: context, isLoading: isBusy);

        if (state.status == UserAddressesStatus.error &&
            state.errorMessage != null) {
          AppMessages.showError(context, message: state.errorMessage!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: CustomAppBar(title: AppStrings.savedAddress),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, UserAddressesState state) {
    if (state.status == UserAddressesStatus.loading &&
        (state.addresses == null || state.addresses!.isEmpty)) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      );
    }

    if (state.status == UserAddressesStatus.error &&
        (state.addresses == null || state.addresses!.isEmpty)) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.errorMessage ?? AppStrings.errorMessage,
                textAlign: TextAlign.center,
                style: AppTextStyles.textStyleMedium14.copyWith(
                  color: AppColors.greyColor,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.read<UserAddressesCubit>().handleIntent(
                  const FetchUserAddressesIntent(),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final addresses = state.addresses ?? [];

    return Column(
      children: [
        Expanded(
          child: addresses.isEmpty
              ? Center(
                  child: Text(
                    AppStrings.enterAddress,
                    style: AppTextStyles.textStyleMedium14.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  itemCount: addresses.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final address = addresses[index];
                    return UserAddressCard(
                      address: address,
                      onDelete: () {
                        final id = address.id;
                        if (id == null || id.isEmpty) return;
                        context.read<UserAddressesCubit>().handleIntent(
                          DeleteAddressIntent(id),
                        );
                      },
                      onEdit: () => _openEditAddress(address),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _openAddAddress,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
                elevation: 0,
              ),
              child: Text(
                AppStrings.addNewAddress,
                style: AppTextStyles.textStyleMedium16.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
