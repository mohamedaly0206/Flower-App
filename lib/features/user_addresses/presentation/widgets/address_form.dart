import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/cubit/user_addresses_cubit.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/intent/user_addresses_intent.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/state/user_addresses_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class AddressForm extends StatelessWidget {
  final TextEditingController streetController;
  final TextEditingController phoneController;
  final TextEditingController usernameController;
  final TextEditingController cityController;

  const AddressForm({
    super.key,
    required this.streetController,
    required this.phoneController,
    required this.usernameController,
    required this.cityController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAddressesCubit, UserAddressesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<UserAddressesCubit, UserAddressesState>(
              builder: (context, state) {
                return Text('Lat: ${state.lat}\nLong: ${state.long}');
              },
            ),
            _MapPlaceholder(),
            const SizedBox(height: 16),
            _AddressTextField(
              id: 'street',
              label: AppStrings.address,
              hint: AppStrings.enterAddress,
              controller: streetController,
              onChanged: (value) => context
                  .read<UserAddressesCubit>()
                  .handleIntent(UpdateStreetIntent(value)),
            ),
            const SizedBox(height: 16),
            _AddressTextField(
              id: 'phone',
              label: AppStrings.phone,
              hint: AppStrings.enterThePhoneNumber,
              controller: phoneController,
              keyboardType: TextInputType.phone,
              onChanged: (value) => context
                  .read<UserAddressesCubit>()
                  .handleIntent(UpdatePhoneIntent(value)),
            ),
            const SizedBox(height: 16),
            _AddressTextField(
              id: 'username',
              label: AppStrings.recipientName,
              hint: AppStrings.enterRecipientName,
              controller: usernameController,
              onChanged: (value) => context
                  .read<UserAddressesCubit>()
                  .handleIntent(UpdateUsernameIntent(value)),
            ),
            const SizedBox(height: 16),
            _AddressTextField(
              id: 'city',
              label: AppStrings.city,
              hint: AppStrings.city,
              controller: cityController,
              onChanged: (value) => context
                  .read<UserAddressesCubit>()
                  .handleIntent(UpdateCityIntent(value)),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: state.status == UserAddressesStatus.saving
                    ? null
                    : () {
                        final cubit = context.read<UserAddressesCubit>();
                        if (state.isEditMode) {
                          cubit.handleIntent(const UpdateAddressIntent());
                        } else {
                          cubit.handleIntent(const AddAddressIntent());
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.placeHolderColor,
                  disabledBackgroundColor: AppColors.placeHolderColor
                      .withValues(alpha: 0.6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  AppStrings.saveAddress,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MapPlaceholder extends StatefulWidget {
  @override
  State<_MapPlaceholder> createState() => _MapPlaceholderState();
}

class _MapPlaceholderState extends State<_MapPlaceholder> {
  MapboxMap? _mapboxMap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: MapWidget(
          key: const ValueKey("address_map"),
          styleUri: MapboxStyles.STANDARD,
          onMapCreated: (mapboxMap) {
            _mapboxMap = mapboxMap;
          },
          onTapListener: (tapContext) {
            final point = tapContext.point.coordinates;

            final lat = point.lat.toString();
            final long = point.lng.toString();

            context.read<UserAddressesCubit>().handleIntent(
              UpdateLocationIntent(lat: lat, long: long),
            );

            debugPrint('LAT: $lat');
            debugPrint('LONG: $long');
          },
        ),
      ),
    );
  }
}

/*class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD0D0D0)
      ..strokeWidth = 1;

    const spacing = 40.0;
    for (var x = 0.0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}*/

class _AddressTextField extends StatelessWidget {
  final String id;
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  const _AddressTextField({
    required this.id,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(id),
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 14, color: AppColors.blackColor),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(
          fontSize: 13,
          color: AppColors.placeHolderColor,
        ),
        hintStyle: const TextStyle(
          fontSize: 13,
          color: AppColors.placeHolderColor,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.greyColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.greyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
