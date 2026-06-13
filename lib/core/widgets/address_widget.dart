import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/features/user_addresses/domain/entities/user_addresses_entity.dart';
import 'package:flower_app/features/user_addresses/presentation/view/address_form_view.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/cubit/user_addresses_cubit.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/intent/user_addresses_intent.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/state/user_addresses_state.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressWidget extends StatefulWidget {
  const AddressWidget({super.key});

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  late final UserAddressesCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<UserAddressesCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.handleIntent(const FetchAddressesIntent());
    });
  }

  Future<void> _openAddAddress() async {
    _cubit.prepareAddForm();

    final saved = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) =>
            BlocProvider.value(value: _cubit, child: const AddressFormView()),
      ),
    );

    if (saved == true && mounted) {
      _cubit.handleIntent(const FetchAddressesIntent());
    }
  }

  String _formatAddressSummary(AddressEntity address) {
    final parts = <String>[
      if ((address.username ?? '').isNotEmpty) address.username!,
      if ((address.city ?? '').isNotEmpty) address.city!,
      if ((address.street ?? '').isNotEmpty) address.street!,
    ];
    return parts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocBuilder<UserAddressesCubit, UserAddressesState>(
      bloc: _cubit,
      builder: (context, state) {
        final isLoading =
            state.status == UserAddressesStatus.loading &&
            state.addresses.isEmpty;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: isLoading
                  ? Text(loc.deliverTo, style: AppTextStyles.textStyleMedium14)
                  : state.addresses.isEmpty
                  ? InkWell(
                      onTap: _openAddAddress,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.noSavedAddressFound,
                            style: AppTextStyles.textStyleMedium14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            loc.tapToAddFirstAddress,
                            style: AppTextStyles.textStyleMedium14.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  : RichText(
                      text: TextSpan(
                        text: loc.deliverTo,
                        style: AppTextStyles.textStyleMedium14.copyWith(
                          color: AppColors.blackColor,
                        ),
                        children: [
                          TextSpan(
                            text: _formatAddressSummary(state.addresses.first),
                            style: AppTextStyles.textStyleMedium14.copyWith(
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            /*if (isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: state.addresses.isEmpty ? _openAddAddress : null,
                  icon: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Theme.of(context).primaryColor,
                    size: 35,
                  ),
                ),*/
          ],
        );
      },
    );
  }
}
