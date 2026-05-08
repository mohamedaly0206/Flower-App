import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';

class CustomOTPTextField extends StatelessWidget {
  const CustomOTPTextField({
    super.key,
    required this.onSubmit,
    required this.state,
  });
  final ValueChanged<String> onSubmit;
  final ForgetPasswordState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        OtpTextField(
          numberOfFields: 6,
          fieldWidth: 46,
          contentPadding: EdgeInsets.all(2),
          margin: EdgeInsets.all(4),
          showFieldAsBox: true,
          autoFocus: true,
          filled: true,
          textStyle: theme.textTheme.headlineLarge,
          cursorColor: theme.colorScheme.primary,
          focusedBorderColor: state.verifyResetCodeState.errorMessage == null
              ? theme.colorScheme.primary
              : theme.colorScheme.error,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          enabledBorderColor: state.verifyResetCodeState.errorMessage == null
              ? theme.colorScheme.primaryFixed
              : theme.colorScheme.error,

          fillColor: theme.colorScheme.onPrimary,

          onSubmit: onSubmit,
        ),
        state.verifyResetCodeState.errorMessage != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    Assets.icons.errorIcon,
                    colorFilter: ColorFilter.mode(
                      theme.colorScheme.error,
                      BlendMode.srcIn,
                    ),
                    width: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    AppStrings.invalidCode,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ],
              )
            : SizedBox(),
      ],
    );
  }
}
