import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/state/profile_states.dart';
import 'package:flower_app/features/app_sections/widgets/custom_guest.dart';
import 'package:flower_app/features/app_sections/widgets/custom_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getIt<FlutterSecureStorage>().read(key: 'token'),
      builder: (context, tokenSnapshot) {
        if (tokenSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: SpinKitFadingCircle(
                color: AppColors.primaryColor,
                size: 50,
              ),
            ),
          );
        }
        final isGuest = tokenSnapshot.data == 'GUEST';
        if (isGuest) {
          return CustomGuest();
        }
        return BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is LogoutSuccess && context.mounted) {
              context.go(AppRouterPaths.kLoginView);
            }
          },
          builder: (context, state) {
            if (state is ProfileSuccess) {
              return CustomLogin(state: state);
            }

            if (state is ProfileError) {
              return Scaffold(body: Center(child: Text(state.message)));
            }

            return Scaffold(
              body: Center(
                child: SpinKitFadingCircle(
                  color: Theme.of(context).colorScheme.primary,
                  size: 50,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
