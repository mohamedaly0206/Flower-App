import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/core/widgets/app_loading.dart';
import 'package:flower_app/core/widgets/app_messages.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/core/shared_features/user_addresses/domain/entities/user_addresses_entity.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/utils/address_localization.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/view/address_form_view.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/view_model/cubit/user_addresses_cubit.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/view_model/intent/user_addresses_intent.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/view_model/state/user_addresses_state.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/widgets/address_card.dart';
import 'package:flower_app/l10n/app_localizations.dart';
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
        const FetchAddressesIntent(),
      );
    });
  }

  Future<void> _openAddressForm({AddressEntity? address}) async {
    final cubit = context.read<UserAddressesCubit>();

    if (address == null) {
      cubit.prepareAddForm();
    } else {
      cubit.prepareEditForm(address);
    }

    AppLoading.toggle(context: context, isLoading: false);

    final saved = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: AddressFormView(address: address),
        ),
      ),
    );

    if (saved == true && mounted) {
      context.read<UserAddressesCubit>().handleIntent(
        const FetchAddressesIntent(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocConsumer<UserAddressesCubit, UserAddressesState>(
      listenWhen: (_, _) => ModalRoute.of(context)?.isCurrent ?? true,
      listener: (context, state) {
        final isBusy = state.status == UserAddressesStatus.loading;
        AppLoading.toggle(context: context, isLoading: isBusy);

        if (state.status == UserAddressesStatus.error &&
            state.errorMessage != null) {
          AppMessages.showError(
            context,
            message: localizeAddressMessage(context, state.errorMessage),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: CustomAppBar(title: loc.savedAddress),
          body: _buildBody(context, state, loc),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    UserAddressesState state,
    AppLocalizations loc,
  ) {
    if (state.status == UserAddressesStatus.loading &&
        state.addresses.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.whiteColor),
      );
    }

    if (state.status == UserAddressesStatus.error && state.addresses.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localizeAddressMessage(context, state.errorMessage) !=
                        (state.errorMessage ?? '')
                    ? localizeAddressMessage(context, state.errorMessage)
                    : (state.errorMessage ?? loc.errorMessage),
                textAlign: TextAlign.center,
                style: AppTextStyles.textStyleMedium14.copyWith(
                  color: AppColors.greyColor,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context
                    .read<UserAddressesCubit>()
                    .handleIntent(const FetchAddressesIntent()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: Text(loc.retry),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: state.addresses.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_off_outlined,
                          size: 48,
                          color: AppColors.greyColor.withValues(alpha: 0.6),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          loc.noSavedAddressesYet,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.textStyleMedium16.copyWith(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () => _openAddressForm(),
                          child: Text(loc.addYourFirstAddress),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  itemCount: state.addresses.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final address = state.addresses[index];
                    return AddressCard(
                      address: address,
                      onDelete: () {
                        final id = address.id;
                        if (id == null || id.isEmpty) return;
                        context.read<UserAddressesCubit>().handleIntent(
                          DeleteAddressIntent(id),
                        );
                      },
                      onEdit: () => _openAddressForm(address: address),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: state.addresses.isEmpty
                ? Text('')
                : ElevatedButton(
                    onPressed: () => _openAddressForm(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: AppColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      loc.addNewAddress,
                      style: AppTextStyles.textStyleMedium16.copyWith(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
