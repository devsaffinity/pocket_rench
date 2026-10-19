import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';

/// Circular progress indicator in brand colors.
class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.size, this.color = AppColors.primary});

  final double? size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final dimension = size ?? AppSizes.loaderSize;
    return SizedBox.square(
      dimension: dimension,
      child: CircularProgressIndicator(
        strokeWidth: AppSizes.loaderStroke,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
