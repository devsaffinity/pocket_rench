import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/theme/app_system_ui.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';

/// Transparent app bar with an optional back button and title.
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title,
    this.showBack = true,
    this.onBack,
    this.actions,
  });

  final String? title;
  final bool showBack;

  /// Defaults to `Get.back()`.
  final VoidCallback? onBack;
  final List<Widget>? actions;

  @override
  Size get preferredSize =>
      Size.fromHeight(AppSizes.tapTarget + AppSizes.spaceM);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: AppSystemUi.lightIcons,
      automaticallyImplyLeading: false,
      toolbarHeight: preferredSize.height,
      leadingWidth: AppSizes.tapTarget + AppSizes.screenPaddingH,
      leading: showBack
          ? Padding(
              padding: EdgeInsets.only(left: AppSizes.spaceM),
              child: AppIconButton(
                svgPath: AppIcons.arrowLeft,
                size: AppSizes.iconBack,
                onPressed: onBack ?? () => Get.back<void>(),
              ),
            )
          : null,
      title: title == null ? null : Text(title!, style: AppTextStyles.label),
      centerTitle: true,
      actions: actions,
    );
  }
}
