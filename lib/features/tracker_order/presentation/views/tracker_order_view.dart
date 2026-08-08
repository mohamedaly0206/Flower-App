import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/tracker_order/presentation/models/order_tracking_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../view_model/cubit/tracker_order_cubit.dart';
import '../view_model/state/tracker_order_state.dart';

class TrackerOrderView extends StatelessWidget {
  final OrderTrackingArgs args;

  const TrackerOrderView({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocBuilder<TrackerOrderCubit, TrackerOrderState>(
        builder: (context, state) {
          if (state is TrackerOrderLoadingState) {
            return Center(
              child: SpinKitFadingCircle(
                color: Theme.of(context).colorScheme.primary,
                size: 50,
              ),
            );
          } else if (state is TrackerOrderErrorState) {
            return Center(child: Text(state.errorMessage));
          } else if (state is TrackerOrderSuccessState) {
            final data = state.locationEntity;

            final bounds = LatLngBounds.fromPoints([
              data.driverLocation,
              data.storeLocation,
              data.userLocation,
            ]);

            return Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCameraFit: CameraFit.bounds(
                      bounds: bounds,
                      padding: const EdgeInsets.only(
                        top: 80,
                        bottom: 250,
                        left: 50,
                        right: 50,
                      ),
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.flower_app',
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: state.routePoints,
                          strokeWidth: 4.0,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: [
                        // Driver Marker
                        Marker(
                          point: data.driverLocation,
                          width: 45,
                          height: 45,
                          child: SvgPicture.asset(
                            Assets.icons.motorcycleDeliveryIcon,
                          ),
                        ),
                        // Store Marker
                        Marker(
                          point: data.storeLocation,
                          width: 20,
                          height: 20,
                          child: SvgPicture.asset(
                            Assets.icons.locationOnIcon,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        // User Marker
                        Marker(
                          point: data.userLocation,
                          width: 20,
                          height: 20,
                          child: SvgPicture.asset(
                            Assets.icons.locationOnIcon,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.transparentColor,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Estimated Arrival
                        Text(
                          AppStrings.estimatedArrival,
                          style: theme.textTheme.displayLarge!.copyWith(
                            color: AppColors.greyColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          args.estimatedDate,
                          style: theme.textTheme.headlineMedium!.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Divider(color: AppColors.placeHolderColor),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundColor: AppColors.transparentColor,
                              child: SvgPicture.asset(
                                Assets.icons.deliveryBoyIcon,
                                width: 40,
                                height: 40,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    args.driverName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    AppStrings.isYourDeliveryHeroForToday,
                                    style: theme.textTheme.displaySmall!
                                        .copyWith(color: AppColors.greyColor),
                                  ),
                                ],
                              ),
                            ),
                            // Call Button
                            IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                Assets.icons.callIcon,
                                color: AppColors.primaryColor,
                                width: 30,
                                height: 30,
                              ),
                            ),
                            // Chat Button
                            IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                Assets.icons.whatsapp,
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),                    
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              AppStrings.orderDetails,
                              style: theme.textTheme.titleMedium!.copyWith(
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: SpinKitFadingCircle(
              color: Theme.of(context).colorScheme.primary,
              size: 50,
            ),
          );
        },
      ),
    );
  }
}
