import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';

/// Search input with a leading magnifier. The controller belongs to the
/// ViewModel.
class AppSearchField extends StatelessWidget {
  const AppSearchField({
    required this.controller,
    required this.hint,
    required this.onChanged,
    super.key,
    this.focusNode,
    this.height,
    this.textStyle,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;
  final FocusNode? focusNode;

  /// Overrides the field height.
  final double? height;

  /// Overrides the text style.
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? AppSizes.textFieldHeight,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.spaceM),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Row(
        children: [
          AppImage(
            AppIcons.search,
            width: AppSizes.searchIcon,
            height: AppSizes.searchIcon,
            fit: BoxFit.contain,
            color: AppColors.textSecondary,
          ),
          SizedBox(width: AppSizes.searchIconGap),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged,
              textInputAction: TextInputAction.search,
              style: textStyle ?? AppTextStyles.input,
              cursorColor: AppColors.primary,
              decoration: InputDecoration.collapsed(
                hintText: hint,
                hintStyle: (textStyle ?? AppTextStyles.input).copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
