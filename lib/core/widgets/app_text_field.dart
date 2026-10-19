import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';

/// Labelled text input. The border color animates between enabled, focused and
/// error states. Controllers and focus nodes are owned by the caller
/// (the ViewModel).
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.textStyle,
    this.contentPaddingV,
    this.minHeight,
    this.enabled = true,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.autofillHints,
  });

  /// Password field. Visibility state lives in the ViewModel.
  AppTextField.password({
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? label,
    String? hint,
    FormFieldValidator<String>? validator,
    String? errorText,
    TextInputAction? textInputAction,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    double? minHeight,
    Color toggleColor = AppColors.iconMuted,
  }) : this(
         key: key,
         controller: controller,
         focusNode: focusNode,
         label: label,
         hint: hint,
         obscureText: obscureText,
         validator: validator,
         errorText: errorText,
         keyboardType: TextInputType.visiblePassword,
         textInputAction: textInputAction,
         onChanged: onChanged,
         onSubmitted: onSubmitted,
         autofillHints: const [AutofillHints.password],
         minHeight: minHeight,
         suffixIcon: Padding(
           padding: EdgeInsets.only(right: AppSizes.fieldSuffixInset),
           child: AppIconButton(
             svgPath: obscureText ? AppIcons.eye : AppIcons.eyeOff,
             color: toggleColor,
             size: AppSizes.iconField,
             onPressed: onToggleVisibility,
           ),
         ),
       );

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int maxLines;

  /// Shows at least this many lines (a text area).
  final int? minLines;

  /// Overrides the text style.
  final TextStyle? textStyle;

  /// Overrides the vertical padding inside the field.
  final double? contentPaddingV;

  /// Overrides the field height.
  final double? minHeight;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Iterable<String>? autofillHints;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppSizes.radiusM),
    borderSide: BorderSide(color: color),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: AppTextStyles.label),
          SizedBox(height: AppSizes.authFieldLabelGap),
        ],
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          minLines: minLines,
          enabled: enabled,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          autofillHints: autofillHints,
          style: textStyle ?? AppTextStyles.input,
          cursorColor: AppColors.primary,
          obscuringCharacter: '•',
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.hint,
            errorText: errorText,
            errorStyle: AppTextStyles.error,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            isDense: true,
            fillColor: AppColors.surface,
            constraints: BoxConstraints(
              minHeight: minHeight ?? AppSizes.textFieldHeight,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.textFieldPaddingH,
              vertical: contentPaddingV ?? AppSizes.textFieldPaddingV,
            ),
            enabledBorder: _border(AppColors.transparent),
            disabledBorder: _border(AppColors.transparent),
            focusedBorder: _border(AppColors.accent),
            errorBorder: _border(AppColors.error),
            focusedErrorBorder: _border(AppColors.error),
          ),
        ),
      ],
    );
  }
}
