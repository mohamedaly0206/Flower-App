import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? hintText;

  const CustomSearchTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.placeHolderColor, fontSize: 18),
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: SvgPicture.asset(
            Assets.icons.searchIcon,
            height: 18,
            width: 18,
          ),
        ),

        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(
          color: AppColors.placeHolderColor,
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({
    Color color = AppColors.placeHolderColor,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }
}
