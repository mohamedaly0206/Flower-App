import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class CustomOTPTextField extends StatelessWidget {
  const CustomOTPTextField({super.key, required this.onSubmit});
  final Function(String) onSubmit;
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
          focusedBorderColor: theme.colorScheme.primary,
          // styles: AppTextStyles.otpTextStyle,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          enabledBorderColor: theme.colorScheme.primaryFixed,

          fillColor: theme.colorScheme.onPrimary,

          onSubmit: onSubmit,
        ),
        //  Row(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //           SvgPicture.asset(
        //             Assets.icons.errorIcon,
        //             colorFilter: ColorFilter.mode(
        //               theme.colorScheme.error,
        //               BlendMode.srcIn,
        //             ),
        //             width: 14,
        //           ),
        //           SizedBox(width: 4),
        //           Text(
        //             AppStrings.invalidCode,
        //             style: theme.textTheme.bodySmall!.copyWith(
        //               color: theme.colorScheme.error,
        //             ),
        //           ),
        //         ],
        //       ),
      ],
    );
  }
}
