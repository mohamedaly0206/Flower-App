import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/view_model/cubit/user_addresses_cubit.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/view_model/intent/user_addresses_intent.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/view_model/state/user_addresses_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class AddressMapWidget extends StatefulWidget {
  const AddressMapWidget({super.key});

  @override
  State<AddressMapWidget> createState() => _AddressMapWidgetState();
}

class _AddressMapWidgetState extends State<AddressMapWidget> {
  static const double _defaultLat = 30.0444;
  static const double _defaultLng = 31.2357;

  MapboxMap? _mapboxMap;
  CircleAnnotationManager? _circleManager;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserAddressesCubit, UserAddressesState>(
      listenWhen: (previous, current) =>
          previous.lat != current.lat || previous.long != current.long,
      listener: (context, state) {
        _syncMapToCoordinates(state);
      },
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            height: 145,
            width: double.infinity,
            child: Stack(
              children: [
                MapWidget(
                  key: const ValueKey('address_map'),
                  styleUri: MapboxStyles.STANDARD,
                  cameraOptions: _cameraOptions(state),
                  onMapCreated: (mapboxMap) => _onMapCreated(mapboxMap, state),
                  onTapListener: (tapContext) {
                    final coordinates = tapContext.point.coordinates;
                    context.read<UserAddressesCubit>().handleIntent(
                      UpdateLocationIntent(
                        lat: coordinates.lat.toString(),
                        long: coordinates.lng.toString(),
                      ),
                    );
                  },
                ),
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    elevation: 2,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => context
                          .read<UserAddressesCubit>()
                          .handleIntent(const RequestCurrentLocationIntent()),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.my_location,
                          color: AppColors.primaryColor,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _onMapCreated(
    MapboxMap mapboxMap,
    UserAddressesState state,
  ) async {
    _mapboxMap = mapboxMap;
    _circleManager = await mapboxMap.annotations
        .createCircleAnnotationManager();
    await _syncMapToCoordinates(state);
  }

  CameraOptions _cameraOptions(UserAddressesState state) {
    final coordinates = _parseCoordinates(state);
    if (coordinates != null) {
      return CameraOptions(
        center: Point(coordinates: Position(coordinates.lng, coordinates.lat)),
        zoom: 15,
      );
    }

    return CameraOptions(
      center: Point(coordinates: Position(_defaultLng, _defaultLat)),
      zoom: 12,
    );
  }

  Future<void> _syncMapToCoordinates(UserAddressesState state) async {
    final coordinates = _parseCoordinates(state);
    if (coordinates == null || _mapboxMap == null) return;

    await _mapboxMap!.flyTo(
      CameraOptions(
        center: Point(coordinates: Position(coordinates.lng, coordinates.lat)),
        zoom: 15,
      ),
      MapAnimationOptions(duration: 300),
    );

    if (_circleManager == null) return;

    await _circleManager!.deleteAll();
    await _circleManager!.create(
      CircleAnnotationOptions(
        geometry: Point(
          coordinates: Position(coordinates.lng, coordinates.lat),
        ),
        circleRadius: 10,
        circleColor: 0xFFD21E6A,
        circleStrokeWidth: 2,
        circleStrokeColor: 0xFFFFFFFF,
      ),
    );
  }

  ({double lat, double lng})? _parseCoordinates(UserAddressesState state) {
    final lat = double.tryParse(state.lat);
    final lng = double.tryParse(state.long);
    if (lat == null || lng == null) return null;
    return (lat: lat, lng: lng);
  }
}
