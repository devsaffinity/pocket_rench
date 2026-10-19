import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';

/// One widget for asset PNG/JPG, asset SVG and network images. The source is
/// inferred from [path]. Shows a static placeholder while a network image
/// loads, and a fallback on error (including a missing asset).
class AppImage extends StatelessWidget {
  const AppImage(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  });

  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;

  /// Tints SVG and raster images.
  final Color? color;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  bool get _isNetwork => path.startsWith('http');
  bool get _isSvg => path.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    final image = _buildImage();
    if (borderRadius == null) return image;
    return ClipRRect(borderRadius: borderRadius!, child: image);
  }

  Widget _buildImage() {
    if (_isNetwork) {
      return CachedNetworkImage(
        imageUrl: path,
        width: width,
        height: height,
        fit: fit,
        color: color,
        placeholder: (_, _) => placeholder ?? _defaultPlaceholder(),
        errorWidget: (_, _, _) => errorWidget ?? _defaultPlaceholder(),
      );
    }

    if (_isSvg) {
      return SvgPicture.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        colorFilter: color == null
            ? null
            : ColorFilter.mode(color!, BlendMode.srcIn),
        errorBuilder: (_, _, _) => errorWidget ?? _defaultPlaceholder(),
      );
    }

    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      color: color,
      errorBuilder: (_, _, _) => errorWidget ?? _defaultPlaceholder(),
    );
  }

  Widget _defaultPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: AppColors.surface,
      alignment: Alignment.center,
      child: Icon(
        Icons.image_outlined,
        color: AppColors.textHint,
        size: AppSizes.iconM,
      ),
    );
  }
}
