import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_fonts.dart';

/// Every text style in the design. Getters, because sizes depend on ScreenUtil.
abstract final class AppTextStyles {
  static TextStyle get _base => const TextStyle(
    fontFamily: AppFonts.family,
    color: AppColors.textPrimary,
    letterSpacing: 0,
  );

  // Headings

  /// Splash wordmark.
  static TextStyle get display => _base.copyWith(
    fontSize: 30.sp,
    fontWeight: AppFonts.semiBold,
    height: 1.1,
    letterSpacing: -0.2.sp,
    color: AppColors.white,
  );

  /// Screen headline.
  static TextStyle get h1 => _base.copyWith(
    fontSize: 20.sp,
    fontWeight: AppFonts.semiBold,
    height: 27 / 20,
  );

  // Body

  /// Welcome screen body copy.
  static TextStyle get body => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.regular,
    height: 22 / 16,
    letterSpacing: 0.2.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle get bodyItalic => body.copyWith(fontStyle: FontStyle.italic);

  static TextStyle get caption => _base.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFonts.regular,
    color: AppColors.textSecondary,
  );

  static TextStyle get error => caption.copyWith(color: AppColors.error);

  // Buttons and links

  static TextStyle get button => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.bold,
    letterSpacing: -0.16.sp,
    color: AppColors.onPrimary,
  );

  /// Label on surface-colored buttons (social sign-in).
  static TextStyle get buttonSecondary =>
      _base.copyWith(fontSize: 14.sp, fontWeight: AppFonts.semiBold);

  static TextStyle get link => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.semiBold,
    color: AppColors.accent,
  );

  /// "Forgot Password?"
  static TextStyle get linkSoft => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.medium,
    color: AppColors.accentSoft,
  );

  // Forms

  static TextStyle get label => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.semiBold,
    height: 20 / 16,
  );

  static TextStyle get input => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.regular,
    height: 18 / 14,
    letterSpacing: 0.2.sp,
    color: AppColors.textMuted,
  );

  static TextStyle get hint => input.copyWith(color: AppColors.textHint);

  static TextStyle get checkboxLabel => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.regular,
    color: AppColors.textMuted,
  );

  /// Terms and privacy consent copy.
  static TextStyle get terms => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.regular,
    height: 19 / 14,
    letterSpacing: 0.2.sp,
    color: AppColors.textMuted,
  );

  static TextStyle get otpDigit =>
      _base.copyWith(fontSize: 18.sp, fontWeight: AppFonts.semiBold);

  /// "OR" between the primary and social buttons.
  static TextStyle get divider => _base.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFonts.regular,
    color: AppColors.textSecondary,
  );

  // Cards

  static TextStyle get cardTitle => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.semiBold,
    height: 22 / 16,
  );

  static TextStyle get bodySmall => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.regular,
    height: 19 / 14,
    letterSpacing: 0.2.sp,
    color: AppColors.textSecondary,
  );

  // Home and onboarding

  static TextStyle get greeting =>
      bodySmall.copyWith(color: AppColors.textHint);

  static TextStyle get sectionTitle => _base.copyWith(
    fontSize: 18.sp,
    fontWeight: AppFonts.semiBold,
    height: 24 / 18,
  );

  /// Names and card titles.
  static TextStyle get itemTitle => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.semiBold,
    height: 20 / 16,
  );

  static TextStyle get mechanicName =>
      itemTitle.copyWith(letterSpacing: -0.08.sp);

  static TextStyle get dropTitle => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.semiBold,
    height: 20 / 14,
    letterSpacing: -0.14.sp,
    color: AppColors.textMuted,
  );

  static TextStyle get dropCaption => _base.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFonts.regular,
    height: 16 / 12,
    letterSpacing: 0.1.sp,
    color: AppColors.textSecondary,
  );

  /// Small purple pill ("Browse Files").
  static TextStyle get pillSmall =>
      _base.copyWith(fontSize: 12.sp, fontWeight: AppFonts.medium);

  /// Purple pill ("Add").
  static TextStyle get pill => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.semiBold,
    letterSpacing: -0.14.sp,
    color: AppColors.white,
  );

  static TextStyle get bannerBody =>
      bodySmall.copyWith(color: AppColors.textSubtle);

  static TextStyle get bannerButton => _base.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFonts.semiBold,
    color: AppColors.onLime,
  );

  static TextStyle get chip => _base.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFonts.regular,
    letterSpacing: 0.2.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle get urgent => _base.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFonts.medium,
    color: AppColors.urgent,
  );

  static TextStyle get navLabel => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.regular,
    height: 17 / 14,
    letterSpacing: 0.1.sp,
  );

  // Explore, filters and profile

  /// Uppercase section label ("SPECIALTIES").
  static TextStyle get sectionLabel => _base.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFonts.medium,
    height: 16 / 12,
    letterSpacing: -0.12.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle get sheetSubtitle => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.regular,
    height: 21 / 16,
    letterSpacing: 0.2.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle get sheetBody => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.regular,
    height: 20 / 14,
    letterSpacing: 0.2.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle get captionSmall => _base.copyWith(
    fontSize: 13.sp,
    fontWeight: AppFonts.regular,
    height: 19 / 13,
    letterSpacing: 0.3.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle get sheetLabel => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.semiBold,
    height: 20 / 14,
  );

  static TextStyle get chipLabel => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.regular,
    letterSpacing: 0.2.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle get chipLabelSelected => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.semiBold,
    color: AppColors.onLime,
  );

  static TextStyle get chipLabelSmall => _base.copyWith(
    fontSize: 13.sp,
    fontWeight: AppFonts.regular,
    letterSpacing: 0.2.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle get chipLabelSmallSelected => _base.copyWith(
    fontSize: 13.sp,
    fontWeight: AppFonts.semiBold,
    letterSpacing: -0.13.sp,
    color: AppColors.onLime,
  );

  static TextStyle get chipLabelXsSelected => _base.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFonts.semiBold,
    color: AppColors.onLime,
  );

  // Messages

  static TextStyle get verifiedTag => _base.copyWith(
    fontSize: 9.sp,
    fontWeight: AppFonts.semiBold,
    letterSpacing: 0.2.sp,
    color: AppColors.verifiedTagText,
  );

  static TextStyle get unreadCount => _base.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFonts.bold,
    color: AppColors.onLime,
  );

  static TextStyle get bubbleOutgoing =>
      bodySmall.copyWith(color: AppColors.onLime);

  static TextStyle get bubbleIncoming =>
      bodySmall.copyWith(color: AppColors.textMuted);

  static TextStyle get recordingTimer => _base.copyWith(
    fontSize: 20.sp,
    fontWeight: AppFonts.semiBold,
    color: AppColors.white,
  );

  static TextStyle get attachLabel => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.regular,
    color: AppColors.textMuted,
  );

  // Requests

  /// Label on choice chips (urgency), the same whether or not selected.
  static TextStyle get choiceChip => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.regular,
    letterSpacing: 0.2.sp,
    color: AppColors.textMuted,
  );

  static TextStyle get pillLarge => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.semiBold,
    letterSpacing: -0.16.sp,
    color: AppColors.white,
  );

  static TextStyle get segmentLabel => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.regular,
    color: AppColors.textSecondary,
  );

  static TextStyle get segmentLabelSelected => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.semiBold,
    letterSpacing: -0.16.sp,
    color: AppColors.onLime,
  );

  static TextStyle get tagLabel => _base.copyWith(
    fontSize: 11.sp,
    fontWeight: AppFonts.semiBold,
    color: AppColors.white,
  );

  static TextStyle get editLink => _base.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFonts.semiBold,
    color: AppColors.accent,
  );

  static TextStyle get gridLabel => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.regular,
    letterSpacing: 0.2.sp,
    color: AppColors.white,
  );

  static TextStyle get rowTitle => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.semiBold,
    height: 20 / 14,
    letterSpacing: -0.14.sp,
  );

  static TextStyle get price => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.semiBold,
    height: 1,
    color: AppColors.accent,
  );

  static TextStyle get statNumber => _base.copyWith(
    fontSize: 18.sp,
    fontWeight: AppFonts.semiBold,
    height: 24 / 18,
    color: AppColors.primary,
  );

  static TextStyle get brandLetter =>
      _base.copyWith(fontSize: 16.sp, fontWeight: AppFonts.semiBold);

  /// Label on small buttons ("Continue to Conversation").
  static TextStyle get buttonSmall => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.bold,
    letterSpacing: -0.14.sp,
    color: AppColors.onPrimary,
  );

  static TextStyle get searchHint => hint;

  // Footers and helper rows

  static TextStyle get footer => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.regular,
    color: AppColors.textMuted,
  );

  static TextStyle get footerLink =>
      footer.copyWith(fontWeight: AppFonts.semiBold, color: AppColors.accent);

  static TextStyle get helper => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.regular,
    color: AppColors.textSecondary,
  );

  static TextStyle get helperAction =>
      helper.copyWith(fontWeight: AppFonts.semiBold);

  // Profile

  static TextStyle get profileName => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.semiBold,
    height: 1,
    color: AppColors.white,
  );

  static TextStyle get profileEmail => greeting.copyWith(height: 1);

  static TextStyle get profileEditLink => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.semiBold,
    height: 20 / 14,
    color: AppColors.accent,
  );

  /// Uppercase section labels, the version line and field hints.
  static TextStyle get profileSection => _base.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFonts.regular,
    height: 16 / 12,
    letterSpacing: 0.2.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle get menuTitle => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.semiBold,
    height: 20 / 14,
    color: AppColors.textMuted,
  );

  static TextStyle get initials => _base.copyWith(
    fontSize: 24.sp,
    fontWeight: AppFonts.bold,
    letterSpacing: 1.sp,
    color: AppColors.textMuted,
  );

  static TextStyle get fieldValueBright =>
      input.copyWith(color: AppColors.textPrimary);

  static TextStyle get aboutTagline =>
      bodySmall.copyWith(color: AppColors.textSubtle);

  static TextStyle get aboutRow =>
      bodySmall.copyWith(color: AppColors.white, height: 20 / 14);

  /// The full request description on its own screen.
  static TextStyle get descriptionFull =>
      reviewBody.copyWith(height: 21 / 14, color: AppColors.textMuted);

  /// Free text the person wrote, shown in the review card.
  static TextStyle get reviewBody => bodySmall.copyWith(letterSpacing: 0.16.sp);

  /// Titles inside settings cards.
  static TextStyle get notifyTitle => itemTitle;

  /// "City-level location only" tag on the privacy card.
  static TextStyle get privacyBadge => itemTitle.copyWith(
    fontSize: 14.sp,
    letterSpacing: -0.28.sp,
    color: AppColors.accent,
  );

  /// Descriptions under a settings title.
  static TextStyle get notifyBody => bodySmall.copyWith(letterSpacing: 0.16.sp);

  // Mechanic onboarding

  static TextStyle get progressLabel => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.regular,
    color: AppColors.white,
  );

  static TextStyle get onbLabel => label.copyWith(color: AppColors.textMuted);

  static TextStyle get onbInput =>
      input.copyWith(fontSize: 16.sp, height: 22 / 16);

  static TextStyle get onbSearchInput =>
      onbInput.copyWith(color: AppColors.white);

  static TextStyle get onbChipSelected =>
      choiceChip.copyWith(color: AppColors.onPrimary);

  static TextStyle get onbSmallInput =>
      input.copyWith(color: AppColors.textMuted, letterSpacing: 0.sp);

  static TextStyle get onbSmallHint =>
      onbSmallInput.copyWith(color: AppColors.textSecondary);

  static TextStyle get priceLabel => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.regular,
    height: 22 / 16,
  );

  static TextStyle get pendingTag => _base.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFonts.semiBold,
    color: AppColors.logoAccent,
  );

  static TextStyle get infoValue => bodySmall.copyWith(
    fontWeight: AppFonts.semiBold,
    color: AppColors.textPrimary,
    letterSpacing: 0.sp,
  );

  static TextStyle get infoValueAccent =>
      infoValue.copyWith(color: AppColors.primary);

  static TextStyle get footnote =>
      caption.copyWith(fontStyle: FontStyle.italic, letterSpacing: 0.2.sp);

  static TextStyle get onbDropTitle => dropTitle.copyWith(letterSpacing: 0);

  static TextStyle get onbDropCaption => dropCaption.copyWith(
    fontSize: 12.25.sp,
    height: 16 / 12.25,
    letterSpacing: 0.125.sp,
  );

  // Mechanic home

  static TextStyle get activityNumber => _base.copyWith(
    fontSize: 20.sp,
    fontWeight: AppFonts.semiBold,
    height: 27 / 20,
  );

  static TextStyle get activityLabel => bodySmall;

  static TextStyle get requestAction =>
      itemTitle.copyWith(fontSize: 14.sp, color: AppColors.white);

  static TextStyle get requestActionAccent =>
      requestAction.copyWith(color: AppColors.onLime);

  /// "Start Live Stream" link on the support request card.
  static TextStyle get liveStream => _base.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFonts.semiBold,
    letterSpacing: -0.2.sp,
    color: AppColors.logoAccent,
  );

  // Alerts

  static TextStyle get alertTitle => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.semiBold,
    height: 20 / 14,
  );

  static TextStyle get alertBody => _base.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFonts.regular,
    height: 16 / 12,
    letterSpacing: 0.2.sp,
  );

  // Mechanic service requests

  static TextStyle get requesterLine =>
      menuTitle.copyWith(color: AppColors.textSecondary);

  static TextStyle get lastMessageLabel => _base.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFonts.regular,
    height: 16 / 12,
    letterSpacing: 0.2.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle get lastMessageQuote => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.semiBold,
    fontStyle: FontStyle.italic,
    height: 20 / 14,
    letterSpacing: -0.2.sp,
  );

  static TextStyle get requestChip =>
      menuTitle.copyWith(fontSize: 12.sp, height: 16 / 12);

  static TextStyle get detailTitle => h1;

  static TextStyle get requesterInitials => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.bold,
    color: AppColors.textMuted,
  );

  static TextStyle get requesterCity => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.regular,
    height: 20 / 16,
    color: AppColors.textSubtle,
  );

  static TextStyle get detailAction => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.semiBold,
    color: AppColors.white,
  );

  // Mechanic professional profile

  static TextStyle get proName => _base.copyWith(
    fontSize: 19.2.sp,
    fontWeight: AppFonts.semiBold,
    height: 24 / 19.2,
    color: AppColors.white,
  );

  static TextStyle get proRole => _base.copyWith(
    fontSize: 14.4.sp,
    fontWeight: AppFonts.regular,
    height: 19 / 14.4,
    color: AppColors.textSecondary,
  );

  static TextStyle get proLabel => proRole;

  static TextStyle get proValue => _base.copyWith(
    fontSize: 14.4.sp,
    fontWeight: AppFonts.semiBold,
    height: 19 / 14.4,
    color: AppColors.textMuted,
  );

  static TextStyle get proBio => _base.copyWith(
    fontSize: 14.4.sp,
    fontWeight: AppFonts.semiBold,
    height: 19 / 14.4,
    color: AppColors.textSecondary,
  );

  static TextStyle get proChip => _base.copyWith(
    fontSize: 12.5.sp,
    fontWeight: AppFonts.regular,
    height: 19 / 12.5,
    color: AppColors.textMuted,
  );

  // Verification status

  static TextStyle get verTitle => _base.copyWith(
    fontSize: 20.sp,
    fontWeight: AppFonts.semiBold,
    height: 24 / 20,
    color: AppColors.white,
  );

  static TextStyle get verBody => _base.copyWith(
    fontSize: 14.4.sp,
    fontWeight: AppFonts.regular,
    height: 19 / 14.4,
    color: AppColors.textSecondary,
  );

  static TextStyle get verRowTitle => _base.copyWith(
    fontSize: 14.sp,
    fontWeight: AppFonts.semiBold,
    height: 20 / 14,
    color: AppColors.white,
  );

  static TextStyle get verStatus =>
      verRowTitle.copyWith(fontSize: 12.8.sp, color: AppColors.success);

  // Pricing tiers and certifications

  /// Screen and section headings on the pricing and certification screens.
  static TextStyle get settingsHeading =>
      h1.copyWith(fontSize: 18.sp, height: 24 / 18);

  /// Section headings between the certification cards.
  static TextStyle get certSectionHeading =>
      settingsHeading.copyWith(fontSize: 16.sp, height: 22 / 16);

  static TextStyle get tierName => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: AppFonts.semiBold,
    height: 19 / 16,
    color: AppColors.white,
  );

  static TextStyle get tierPrice =>
      tierName.copyWith(height: 24 / 16, color: AppColors.logoAccent);

  static TextStyle get tierBody => _base.copyWith(
    fontSize: 14.4.sp,
    fontWeight: AppFonts.regular,
    height: 19 / 14.4,
    color: AppColors.textSecondary,
  );

  static TextStyle get dashedAction => _base.copyWith(
    fontSize: 12.5.sp,
    fontWeight: AppFonts.bold,
    color: AppColors.logoAccent,
  );

  static TextStyle get certChip => _base.copyWith(
    fontSize: 10.8.sp,
    fontWeight: AppFonts.semiBold,
    height: 16 / 10.8,
  );

  static TextStyle get certTileTitle =>
      tierName.copyWith(fontSize: 14.sp, height: 19 / 14);

  static TextStyle get certTileHint => _base.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFonts.regular,
    height: 16 / 12,
    color: AppColors.textSubtle,
  );

  static TextStyle get certSubmit => requestActionAccent;

  static TextStyle get writeInInput =>
      onbSmallInput.copyWith(letterSpacing: 0.18.sp);

  static TextStyle get writeInHint =>
      onbSmallHint.copyWith(letterSpacing: 0.18.sp);
}
