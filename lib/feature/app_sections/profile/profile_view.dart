import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/config/security_storage/security_storage.dart';
import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/core/values/api_param.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final securityStorage = getIt<SecurityStorage>();
                securityStorage.deleteSecuredString(ApiParam.token);
                context.go(AppRouterPaths.kLoginView);
              },
              child: Text(
                AppStrings.confirmLogout,
                style: AppTextStyles.textStyleMedium16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
