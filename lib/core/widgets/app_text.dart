import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';

/// Text with a style from [AppTextStyles]. Use the named constructors for the
/// common styles.
class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    required this.style,
    super.key,
    this.color,
    this.align,
    this.maxLines,
    this.overflow,
  });

  AppText.display(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  }) : this(
         text,
         key: key,
         style: AppTextStyles.display,
         color: color,
         align: align,
         maxLines: maxLines,
         overflow: overflow,
       );

  AppText.heading(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  }) : this(
         text,
         key: key,
         style: AppTextStyles.h1,
         color: color,
         align: align,
         maxLines: maxLines,
         overflow: overflow,
       );

  AppText.body(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  }) : this(
         text,
         key: key,
         style: AppTextStyles.body,
         color: color,
         align: align,
         maxLines: maxLines,
         overflow: overflow,
       );

  AppText.caption(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  }) : this(
         text,
         key: key,
         style: AppTextStyles.caption,
         color: color,
         align: align,
         maxLines: maxLines,
         overflow: overflow,
       );

  final String text;
  final TextStyle style;
  final Color? color;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: color == null ? style : style.copyWith(color: color),
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
