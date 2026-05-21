import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: ElevatedButton(
            key: const Key('profile_edit_profile_button'),
            onPressed: () => context.push(AppRouterPaths.kEditProfileView),
            child: const Text('Edit Profile'),
          ),
        ),
      ),
    );
  }
}
