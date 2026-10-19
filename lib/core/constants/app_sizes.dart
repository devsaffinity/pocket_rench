import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Spacing, paddings, radii and component dimensions. Values are design-frame
/// dp scaled through ScreenUtil.
abstract final class AppSizes {
  /// Figma frame the design was drawn on.
  static const Size designSize = Size(430, 932);

  /// One physical pixel on a 2x display.
  static const double hairline = 0.5;

  // Spacing scale
  static double get spaceXS => 4.h;
  static double get spaceS => 8.h;
  static double get spaceM => 16.h;
  static double get spaceL => 24.h;
  static double get spaceXL => 32.h;

  // Paddings
  static double get screenPaddingH => 32.w;
  static double get sheetPaddingH => 31.w;

  // Radii
  static double get radiusS => 8.r;
  static double get radiusM => 12.r;
  static double get radiusL => 20.r;
  static double get radiusCheckbox => 5.r;

  // Icons
  static double get iconS => 16.r;
  static double get iconM => 24.r;
  static double get iconField => 20.r;
  static double get tapTarget => 44.r;
  static double get iconBack => 21.r;

  // Buttons and inputs
  static double get buttonHeight => 50.h;
  static double get buttonHeightSecondary => 47.h;
  static double get buttonHeightTall => 52.h;
  static double get buttonIconGap => 8.5.w;
  static double get textFieldHeight => 47.h;
  static double get textFieldPaddingH => 12.w;
  static double get fieldSuffixInset => 4.w;
  static double get textFieldPaddingV => 14.5.h;
  static double get loaderSize => 22.r;
  static double get loaderStroke => 2.5.r;
  static double get checkboxSize => 20.r;
  static double get checkboxIconSize => 14.r;
  static double get checkboxGap => 12.5.w;

  // Logo
  static double get logoMarkWidth => 38.w;
  static double get logoMarkHeight => 30.w;
  static double get splashLogoGap => 16.w;

  // Welcome
  static double get welcomeHeroHeight => 500.h;
  static double get welcomeLogoLeft => 31.w;
  static double get welcomeLogoTop => 56.h;
  static double get welcomeContentTop => 32.h;
  static double get welcomeHeadingBodyGap => 12.h;
  static double get welcomeBodyButtonGap => 28.h;
  static double get welcomeButtonLinkGap => 16.h;
  static double get welcomeLinkGap => 6.w;

  // Auth screens
  static double get authLogoLeft => 31.w;
  static double get authLogoTop => 56.h;
  static double get authBackTop => 52.h;
  static double get authBackLeft => 27.w;
  static double get authTitleTop => 132.h;
  static double get authTitleTopRole => 124.h;
  static double get authTitleSubtitleGap => 8.h;
  static double get authHeaderBodyGap => 41.h;
  static double get authBodyGapCompact => 25.h;
  static double get authBodyGapCards => 32.h;
  static double get authFieldLabelGap => 13.h;
  static double get authFieldGap => 17.h;
  static double get authRememberTop => 20.h;
  static double get authButtonTopGap => 40.h;
  static double get authTermsGap => 24.h;
  static double get promptGap => 5.w;
  static double get dividerPaddingV => 16.h;
  static double get dividerPaddingVLoose => 24.h;
  static double get otpHelperTop => 32.h;
  static double get otpHelperGap => 12.h;
  static double get otpResendGap => 9.w;
  static double get authBottomPadding => 32.h;
  static double get authFooterBottomPadding => 25.h;
  static double get authFooterBottomPaddingLow => 0.h;
  static double get authFooterTopGap => 24.h;

  // Role cards
  static double get roleCardPadding => 15.r;
  static double get roleCardGap => 16.h;
  static double get roleIconCircle => 36.r;
  static double get roleIconSize => 18.r;
  static double get roleCardIconTitleGap => 12.h;
  static double get roleCardTitleDescGap => 8.h;

  // OTP
  static double get otpBoxHeight => 56.h;
  static double get otpBoxGap => 8.w;
  static double get otpBoxRadius => 8.r;

  // Social / divider
  static double get dividerTextGap => 13.w;
  static double get socialButtonGap => 12.h;

  // Entry animation travel distance
  static double get entryOffset => 16.h;

  // Bottom sheet
  static double get sheetHandleWidth => 40.w;
  static double get sheetHandleHeight => 4.h;

  // Profile setup
  static double get uploadLabelGap => 17.h;
  static double get uploadCardPaddingV => 17.h;
  static double get uploadIconSize => 24.r;
  static double get uploadIconTitleGap => 8.h;
  static double get uploadTitleCaptionGap => 4.h;
  static double get uploadCaptionButtonGap => 12.h;
  static double get pillSmallHeight => 32.h;
  static double get pillSmallPaddingH => 25.w;
  static double get selectChevronInset => 10.w;

  // All set
  static double get allSetCircle => 100.r;
  static double get allSetIcon => 38.r;
  static double get allSetCircleTitleGap => 20.h;
  static double get allSetTitleBodyGap => 8.h;
  static double get allSetBodyButtonGap => 20.h;

  // Home
  static double get homeTop => 64.5.h;
  static double get homePaddingLeft => 33.w;
  static double get homePaddingRight => 31.w;
  static double get homeAvatar => 44.r;
  static double get homeAvatarGap => 12.w;
  static double get homeBellBox => 40.r;
  static double get homeBellIcon => 24.r;
  static double get homeHeaderBannerGap => 32.5.h;
  static double get bannerHeight => 180.h;
  static double get bannerImageWidth => 183.w;
  static double get bannerPaddingTop => 27.h;
  static double get bannerPaddingH => 16.w;
  static double get bannerTitleBodyGap => 6.h;
  static double get bannerBodyButtonGap => 12.h;
  static double get bannerButtonHeight => 32.h;
  static double get bannerButtonPaddingH => 12.w;
  static double get bannerButtonRadius => 8.r;
  static double get homeSectionGap => 28.h;
  static double get homeTitleCardGap => 20.h;
  static double get mechanicCardGap => 16.h;
  static double get mechanicNameSubtitleGap => 5.h;
  static double get mechanicSubtitleChipsGap => 12.h;
  static double get mechanicBadgeGap => 10.w;
  static double get mechanicNameTop => 1.h;
  static double get mechanicCardPaddingCompact => 14.r;
  static double get toggleSubtitleGap => 1.h;
  static double get mechanicBadgeSize => 16.r;
  static double get chipHeight => 28.h;
  static double get chipPaddingH => 10.w;
  static double get chipGap => 8.w;
  static double get seeAllTop => 20.h;
  static double get seeAllRequestsGap => 28.h;
  static double get requestsRowHeight => 35.h;
  static double get requestsRowCardGap => 20.h;
  static double get addButtonPaddingH => 10.5.w;
  static double get requestIconBox => 36.r;
  static double get requestIconSize => 20.r;
  static double get requestIconRadius => 8.r;
  static double get urgentHeight => 24.h;
  static double get urgentPaddingH => 8.5.w;
  static double get urgentRadius => 8.r;
  static double get homeBottomPadding => 24.h;
  static double get addIconSize => 16.r;
  static double get addIconGap => 6.w;

  // Bottom navigation
  static double get navPaddingTop => 16.h;
  static double get navPaddingBottom => 17.h;
  static double get navPaddingH => 10.w;
  static double get navIconBox => 24.r;
  static double get navIconLabelGap => 7.h;

  // Explore
  static double get exploreTitleSearchGap => 20.h;
  static double get searchIcon => 18.r;
  static double get searchIconGap => 6.5.w;
  static double get exploreSearchChipsGap => 21.h;
  static double get exploreChipsListGap => 31.h;
  static double get exploreSearchListGap => 32.5.h;
  static double get filterBarChipHeight => 35.h;
  static double get filterBarChipPaddingH => 14.w;
  static double get filterBarChipGap => 8.w;

  // Chips
  static double get chipPillHeight => 32.h;
  static double get chipPillPaddingH => 14.w;
  static double get sheetChipHeight => 31.h;
  static double get sheetChipPaddingH => 12.w;

  // Switch and radio
  static double get switchWidth => 36.5.w;
  static double get switchHeight => 20.h;
  static double get switchKnob => 16.r;
  static double get switchInset => 2.r;
  static double get radioSize => 16.r;
  static double get radioDot => 6.r;
  static double get radioLabelGap => 7.5.w;
  static double get radioItemGap => 13.w;

  // Sheets
  static double get sheetRadius => 28.r;
  static double get sheetHeaderTop => 24.5.h;
  static double get sheetHeaderTopCompact => 17.h;
  static double get sheetCloseRise => 9.h;
  static double get sheetCloseOverhang => 14.5.w;
  static double get sheetCloseTopCompact => 16.h;
  static double get sheetHeaderBodyGap => 24.h;
  static double get sheetTitleSubtitleGap => 10.h;
  static double get sheetLabelGap => 11.h;
  static double get sheetGroupGap => 19.5.h;
  static double get sheetGroupGapTight => 19.5.h;
  static double get sheetVerifiedGap => 20.h;
  static double get sheetChipGap => 8.r;
  static double get sheetRowGap => 6.5.h;
  static double get sheetBottomPadding => 24.h;
  static double get sheetButtonGap => 24.h;
  static double get sheetBlur => 8;
  static double get requestCardGap => 12.h;
  static double get requestCardPadding => 15.r;
  static double get requestTitleSubtitleGap => 3.h;
  static double get sheetDividerPaddingV => 12.h;
  static double get sheetDividerBottom => 11.h;
  static double get contactLabelExtraGap => 1.h;

  // Mechanic profile
  static double get profileBarTop => 52.h;
  static double get profileBarInset => 28.w;
  static double get profileKebabInset => 26.w;
  static double get profileKebabIcon => 20.r;
  static double get profileChipPaddingH => 12.w;
  static double get profileSkillPaddingH => 10.w;
  static double get profileAvatar => 80.r;
  static double get profileAvatarTop => 124.h;
  static double get profileAvatarNameGap => 12.h;
  static double get profileNameRoleGap => 3.5.h;
  static double get profileRoleCityGap => 4.5.h;
  static double get profileHeaderSectionGap => 32.h;
  static double get profileSectionGap => 20.h;
  static double get profileLabelGap => 12.h;
  static double get profileChipGap => 8.5.w;
  static double get profileBadgeSize => 20.r;
  static double get profileBadgeGap => 8.5.w;
  static double get brandCardPaddingV => 11.h;
  static double get brandCardPaddingH => 12.w;
  static double get brandTile => 32.r;
  static double get brandTileRadius => 8.r;
  static double get brandTileGap => 12.w;
  static double get brandCardGap => 12.h;
  static double get pricingPadding => 12.5.r;
  static double get pricingTitleDescGap => 7.h;
  static double get pricingDividerGap => 8.h;
  static double get statCardGap => 12.w;
  static double get statCardPaddingH => 12.w;
  static double get statCardPaddingTop => 13.h;
  static double get statCardPaddingBottom => 10.h;
  static double get profileButtonTopGap => 32.5.h;
  static double get profileBottomPadding => 38.5.h;

  // Conversation list
  static double get convCardPaddingH => 16.w;
  static double get convCardPaddingV => 15.5.h;
  static double get convAvatarGap => 12.5.w;
  static double get convNameMessageGap => 7.h;
  static double get convTimeTop => 4.h;
  static double get convBadge => 18.r;
  static double get convCardGap => 16.h;
  static double get convListTop => 32.h;

  // Empty messages
  static double get emptyCircle => 80.r;
  static double get emptyCenterShift => 81.h;
  static double get emptyIcon => 36.r;
  static double get emptyCircleTitleGap => 24.h;
  static double get emptyTitleBodyGap => 8.5.h;
  static double get emptyBodyButtonGap => 24.h;

  // Chat header
  static double get chatHeaderTop => 57.h;
  static double get chatBackGap => 6.w;
  static double get chatPhoneInset => 18.w;
  static double get chatPhoneIcon => 19.r;
  static double get chatNameRoleGap => 6.5.h;
  static double get chatNameTagGap => 8.w;
  static double get chatTagHeight => 17.5.h;
  static double get chatTagPaddingH => 6.w;
  static double get chatTagRadius => 4.r;
  static double get chatHeaderCardGap => 32.5.h;

  // Chat body
  static double get chatCardPadding => 16.r;
  static double get chatCardLabelGap => 8.h;
  static double get chatCardTitleGap => 9.h;
  static double get chatCardBubbleGap => 24.h;
  static double get chatItemGap => 16.h;
  static double get viewRequestArrow => 14.r;
  static double get viewRequestArrowGap => 4.w;
  static double get chatBubblePadding => 12.r;
  static double get chatBubbleRadius => 14.r;
  static double get chatBubbleTailRadius => 4.r;
  static double get chatBubbleMaxWidth => 240.w;
  static double get chatMediaWidth => 187.5.w;
  static double get chatMediaHeight => 137.5.h;
  static double get chatMediaBorder => 1.5.r;
  static double get chatListBottom => 16.5.h;
  static double get chatPlayIcon => 40.r;

  // Chat input
  static double get chatInputTop => 20.h;
  static double get chatInputBottom => 20.5.h;
  static double get chatInputLeft => 16.w;
  static double get chatInputRight => 14.w;
  static double get chatAddButton => 40.r;
  static double get chatAddIcon => 20.r;
  static double get chatInputGap => 12.5.w;
  static double get chatFieldHeight => 42.5.h;
  static double get chatMicGap => 10.5.w;
  static double get chatMicIcon => 24.r;

  // Panel sheets (dimmed, no blur)
  static double get panelRadius => 24.r;
  static double get panelTitleTop => 18.5.h;
  static double get panelTitleRowsGap => 16.5.h;
  static double get attachRowHeight => 50.h;
  static double get attachRowGap => 12.h;
  static double get attachIcon => 24.r;
  static double get attachIconGap => 10.w;

  // Recording sheet
  static double get recordingPaddingH => 24.w;
  static double get recordingTitleTop => 29.5.h;
  static double get recordingDot => 10.r;
  static double get recordingDotGap => 9.5.w;
  static double get recordingTitleWaveGap => 25.5.h;
  static double get waveBarWidth => 4.w;
  static double get waveBarGap => 4.w;
  static double get waveMaxHeight => 38.h;
  static double get recordingWaveTimerGap => 25.h;
  static double get recordingTimerButtonsGap => 23.h;
  static double get recordingButtonGap => 12.w;
  static double get recordingBottom => 32.5.h;

  // Requests list
  static double get requestsAddIcon => 20.r;
  static double get requestsAddGap => 6.w;
  static double get requestsAddPaddingH => 12.w;
  static double get requestsSegmentTop => 20.h;
  static double get segmentHeight => 50.h;
  static double get segmentPadding => 6.r;
  static double get segmentRadius => 8.r;
  static double get segmentListGap => 32.h;
  static double get requestListGap => 16.h;
  static double get requestCardIconTitleGap => 12.5.h;
  static double get requestCardTitleSubGap => 5.5.h;

  // New request: details
  static double get urgencyChipHeight => 35.h;
  static double get urgencyChipPaddingH => 16.w;
  static double get urgencyChipGap => 8.5.w;
  static double get selectCompactHeight => 48.h;
  static double get selectCompactPaddingLeft => 12.5.w;
  static double get selectCompactChevronInset => 5.75.w;
  static double get yearFieldWidth => 79.5.w;
  static double get modelYearGap => 12.5.w;
  static double get textareaPaddingV => 16.h;

  // New request: files
  static double get attachGridGap => 12.5.r;
  static double get attachTileHeight => 79.h;
  static double get attachTileIcon => 24.r;
  static double get attachTileIconGap => 8.h;
  static double get uploadedLabelTop => 33.h;
  static double get uploadedLabelGap => 17.h;
  static double get fileRowGap => 12.5.h;
  static double get fileRowPaddingLeft => 12.w;
  static double get fileRowPaddingRight => 10.w;
  static double get fileRowPaddingV => 12.h;
  static double get fileThumb => 44.r;
  static double get fileThumbRadius => 8.r;
  static double get fileThumbGap => 12.w;
  static double get fileTagGap => 6.h;
  static double get fileProgressGap => 11.h;
  static double get fileTagHeight => 18.h;
  static double get fileTagPaddingH => 8.w;
  static double get fileTagRadius => 6.r;
  static double get progressHeight => 6.h;
  static double get fileRemoveIcon => 18.r;

  // New request: review
  static double get reviewPadding => 20.r;
  static double get reviewDividerGap => 16.5.h;
  static double get reviewDividerGapAbove => 15.h;
  static double get reviewHeaderContentGap => 11.h;
  static double get reviewChipTopGap => 12.h;
  static double get categoryTagHeight => 23.h;
  static double get categoryTagPaddingH => 10.5.w;
  static double get categoryTagRadius => 6.r;
  static double get reviewUrgencyHeight => 27.h;
  static double get reviewThumb => 48.r;
  static double get reviewThumbGap => 8.5.w;
  static int get reviewDescriptionLines => 3;
  static double get requestDescriptionPaddingH => 48.w;
  static double get requestDescriptionLift => 45.h;
  static double get requestDetailsBodyGap => 33.h;
  static double get requestDetailsFooterGap => 18.h;

  // Request submitted
  static double get submittedCircle => 84.r;
  static double get submittedIcon => 40.r;
  static double get submittedCircleTitleGap => 19.5.h;
  static double get submittedTitleBodyGap => 11.5.h;
  static double get submittedBodyButtonGap => 20.5.h;
  static double get submittedButtonGap => 12.h;

  // Profile tab
  static double get accountTop => 126.75.h;
  static double get accountAvatar => 64.r;
  static double get accountAvatarGap => 16.w;
  static double get accountNameEmailGap => 9.5.h;
  static double get accountEmailLinkGap => 8.5.h;
  static double get accountHeaderSectionGap => 31.h;
  static double get accountSectionLabelGap => 12.h;
  static double get accountSectionGap => 16.h;
  static double get accountRowHeight => 56.h;
  static double get accountRowHeightCompact => 52.h;
  static double get accountBadgeGap => 8.w;
  static double get accountBadge => 16.r;
  static double get accountRowGap => 12.h;
  static double get accountRowPadding => 16.w;
  static double get accountRowTrailing => 14.5.w;
  static double get accountRowIconBox => 28.r;
  static double get accountRowIconBoxRadius => 6.r;
  static double get accountRowIcon => 16.r;
  static double get accountRowIconTitleGap => 12.w;
  static double get accountChevron => 18.r;
  static double get accountVersionTop => 12.h;

  // Settings screens (edit profile, notifications, privacy, password, about)
  static double get settingsGapBelowTitle => 20.h;
  static double get settingsGapBelowTitleLoose => 32.h;
  static double get settingsBottomPadding => 38.h;
  static double get editProfileBottomPadding => 54.h;
  static double get fieldHeightIcon => 48.h;
  static double get fieldIconGap => 12.w;
  static double get editAvatar => 96.r;
  static double get editBadge => 28.r;
  static double get editBadgeIcon => 14.r;
  static double get editBadgeInset => 2.r;
  static double get editBadgeRing => 2.r;
  static double get editFieldGap => 25.h;
  static double get passwordTopGap => 33.h;
  static double get passwordFieldGap => 21.h;
  static double get passwordHintTop => 12.h;
  static double get passwordHintBottom => 21.h;

  // Notification preferences
  static double get notifyCardPaddingTop => 9.h;
  static double get notifyCardPaddingBottom => 8.h;
  static double get notifyRowPaddingH => 20.w;
  static double get notifyRowPaddingV => 12.h;
  static double get notifyTitleBodyGap => 5.h;
  static double get notifyTextSwitchGap => 12.w;
  static double get notifySwitchWidth => 37.w;
  static double get notifySwitchKnob => 17.r;
  static double get notifySwitchInset => 1.5.r;

  // Privacy
  static double get privacyCardPadding => 16.r;
  static double get privacyCardPaddingBottom => 14.h;
  static double get privacyCardPaddingBottomMechanic => 16.h;
  static double get privacyCheckCircle => 24.r;
  static double get privacyCheckIcon => 14.r;
  static double get privacyTitleBodyGap => 8.h;
  static double get privacyBodyBadgeGap => 12.h;
  static double get privacyDot => 8.r;
  static double get privacyDotGap => 6.w;

  // About
  static double get aboutLogoCircle => 64.r;
  static double get aboutLogoIcon => 29.r;
  static double get aboutLogoNameGap => 20.h;
  static double get aboutNameTaglineGap => 3.5.h;
  static double get aboutTaglineCardGap => 20.5.h;
  static double get aboutRowHeight => 52.h;
  static double get aboutRowPadding => 16.w;
  static double get aboutRowIcon => 20.r;
  static double get aboutRowIconGap => 12.w;

  // Mechanic onboarding
  static double get progressBarHeight => 8.h;
  static double get progressTextGap => 14.w;
  static double get onbBodyTopGap => 10.h;
  static double get onbProgressGap => 40.h;
  static double get onbPriceFieldPaddingV => 12.5.h;
  static double get onbLabelControlGap => 17.h;
  static double get onbSectionGap => 21.h;
  static double get onbSelectHeight => 50.h;
  static double get onbChipHeight => 35.h;
  static double get onbChipPaddingH => 16.w;
  static double get onbChipGapTight => 8.5.w;
  static double get onbChipRunGapTight => 8.h;
  static double get onbChipGapLoose => 12.w;
  static double get onbChipRunGapLoose => 12.h;
  static double get onbHintTop => 5.5.h;
  static double get onbHintBottom => 16.h;
  static double get onbSearchChipsGap => 20.h;
  static double get onbAddRowGap => 12.w;
  static double get onbAddFieldHeight => 48.h;
  static double get onbAddButtonWidth => 71.w;
  static double get onbPriceFieldWidth => 173.w;
  static double get onbPriceFieldHeight => 43.h;
  static double get onbPriceRowGap => 12.h;
  static double get onbDocRowHeight => 70.h;
  static double get onbDocRowPaddingLeft => 14.w;
  static double get onbDocIconBox => 36.r;
  static double get onbDocIconGap => 10.w;
  static double get onbDocIcon => 18.r;
  static double get onbDocRemoveIcon => 16.r;
  static double get onbDocRowPaddingRight => 14.w;
  static double get onbDropPaddingTop => 12.h;
  static double get onbDropPaddingBottom => 16.h;
  static double get onbDropIconTitleGap => 7.5.h;
  static double get onbDropTitleCaptionGap => 8.h;
  static double get onbDropCaptionButtonGap => 20.h;
  static double get onbFooterGap => 40.h;
  static double get onbSubmittedShield => 50.r;
  static double get onbSubmittedCircleTagGap => 20.h;
  static double get onbSubmittedTagHeight => 28.h;
  static double get onbSubmittedTagPaddingH => 16.5.w;
  static double get onbSubmittedTagTitleGap => 16.5.h;
  static double get onbSubmittedTitleBodyGap => 8.h;
  static double get onbSubmittedBodyCardGap => 20.h;
  static double get onbSubmittedCardPadding => 16.r;
  static double get onbSubmittedCardRowGap => 12.h;
  static double get onbSubmittedButtonFootnoteGap => 12.h;

  // Mechanic home
  static double get mechSectionTop => 21.5.h;
  static double get mechTitleCardGap => 12.5.h;
  static double get mechStatHeight => 86.h;
  static double get mechStatGap => 12.5.w;
  static double get mechStatPadding => 16.r;
  static double get mechStatPaddingTop => 16.5.h;
  static double get mechStatNumberLabelGap => 7.5.h;
  static double get mechRequestsTop => 20.h;
  static double get mechRequestsTitleGap => 20.h;
  static double get mechRequestTitleSubGap => 4.5.h;
  static double get mechButtonsTop => 12.5.h;
  static double get mechButtonHeight => 40.h;
  static double get mechButtonGap => 8.w;
  static double get mechButtonRadius => 10.r;

  // Mechanic chat
  static double get chatStatusDot => 6.r;
  static double get chatStatusLift => 2.h;
  static double get chatLiveRowExtra => 1.h;
  static double get chatStatusDotGap => 6.w;
  static double get chatLiveDot => 5.r;
  static double get chatLiveDotGap => 5.w;
  static double get chatMechanicOutgoingInset => 8.w;
  static double get chatMechanicMediaWidth => 180.w;
  static double get chatMechanicMediaHeight => 130.h;

  // Alerts
  static double get alertTitleSectionGap => 32.h;
  static double get alertLabelCardGap => 16.h;
  static double get alertSectionGap => 20.h;
  static double get alertCardGap => 16.h;
  static double get alertCardPadding => 12.r;
  static double get alertIconCircle => 40.r;
  static double get alertIcon => 18.r;
  static double get alertIconTextGap => 11.5.w;
  static double get alertTitleBodyGap => 3.h;
  static double get alertDot => 8.r;
  static double get alertDotGap => 8.w;

  // Mechanic service requests
  static double get mechCardIconTitleGap => 13.h;
  static double get svcResolvedBottom => 15.h;
  static double get svcRequesterGap => 4.5.h;
  static double get svcBoxTop => 15.h;
  static double get svcBoxHeight => 59.h;
  static double get svcBoxPaddingH => 10.r;
  static double get svcBoxPaddingTop => 10.5.h;
  static double get svcBoxLabelGap => 2.5.h;
  static double get svcBoxButtonGap => 15.5.h;
  static double get svcPrimaryButtonHeight => 40.h;
  static double get svcDetailTop => 110.5.h;
  static double get svcDetailTagGap => 16.w;
  static double get svcDetailSummaryGap => 6.h;
  static double get svcDetailChipsGap => 20.h;
  static double get svcChipHeight => 28.h;
  static double get svcChipPaddingH => 12.w;
  static double get svcChipGap => 8.5.w;
  static double get svcSectionGap => 33.h;
  static double get svcLabelCardGap => 13.h;
  static double get svcLabelThumbGap => 13.h;
  static double get svcSectionGapLoose => 21.h;
  static double get svcLabelRequesterGap => 17.h;
  static double get svcDescriptionPadding => 16.r;
  static double get svcThumb => 60.r;
  static double get svcThumbGap => 12.5.w;
  static double get svcThumbRadius => 8.r;
  static double get svcRequesterCardWidth => 342.w;
  static double get svcRequesterCardHeight => 64.h;
  static double get svcRequesterCirclePadding => 12.r;
  static double get svcRequesterCircle => 40.r;
  static double get svcRequesterTextGap => 12.5.w;
  static double get svcButtonsTop => 32.h;
  static double get svcDetailButtonHeight => 47.h;
  static double get svcDetailButtonGap => 8.h;
  static double get svcDetailBottom => 32.h;

  // Mechanic professional profile
  static double get proBottom => 35.5.h;
  static double get proSectionGap => 20.h;
  static double get proAvatarNameGap => 13.h;
  static double get proNameRoleGap => 4.h;
  static double get proRoleCityGap => 7.h;
  static double get proCityLabelGap => 34.h;
  static double get proLabelCardGap => 12.h;
  static double get proCardPaddingH => 16.w;
  static double get proCardPaddingV => 4.h;
  static double get proRowPaddingV => 11.5.h;
  static double get proBioGap => 7.h;
  static double get proBrandCardPadding => 12.r;
  static double get proChipGap => 6.5.r;
  static double get proBrandChipHeight => 36.h;
  static double get proSkillChipHeight => 28.h;
  static double get proChipPaddingH => 14.5.w;
  static double get proSkillChipPaddingH => 10.w;
  static double get proChipRunGap => 6.r;
  static double get proSkillsGap => 8.5.h;
  static double get proExpertiseLabelGap => 16.h;
  static double get proButtonTop => 32.5.h;

  // Verification status
  static double get verPaddingH => 36.w;
  static double get verCircle => 60.r;
  static double get verCheckIcon => 32.r;
  static double get verClockIcon => 30.r;
  static double get verCircleTitleGap => 13.h;
  static double get verTitleBodyGap => 10.h;
  static double get verBodyWidth => 280.w;
  static double get verBodyLabelGap => 20.h;
  static double get verLabelRowsGap => 16.h;
  static double get verRowGap => 10.h;
  static double get verRowHeight => 51.h;
  static double get verRowPadding => 16.w;
  static double get verCheckNudge => 2.5.w;
  static double get verStatusIcon => 13.r;
  static double get verStatusGap => 4.w;

  // Pricing tiers and certifications
  static double get priceTitleGap => 16.h;
  static double get tierCardGap => 12.h;
  static double get tierCardPaddingH => 14.w;
  static double get tierCardPaddingTop => 13.h;
  static double get tierCardPaddingBottom => 14.5.h;
  static double get tierNameBodyGap => 4.5.h;
  static double get tierPriceGap => 8.w;
  static double get tierTextSwitchGap => 12.w;
  static const double disabledTierOpacity = 0.5;
  static double get dashedButtonHeight => 50.h;
  static double get dashedIcon => 18.r;
  static double get dashedIconGap => 8.w;
  static double get priceMinimumTop => 32.h;
  static double get minimumCardPaddingTop => 15.h;
  static double get minimumTitleBodyGap => 6.h;
  static double get minimumCardPaddingBottom => 14.h;
  static double get minimumTextPriceGap => 8.w;
  static double get minimumPriceEditGap => 10.5.w;
  static double get minimumEditIcon => 19.r;
  static double get certSectionGap => 32.h;
  static double get certTitleCardGap => 16.h;
  static double get tierNameRowHeight => 24.h;
  static double get certMenuInset => 4.25.w;
  static double get certMenuIcon => 17.5.r;
  static double get certMenuLift => 2.5.h;
  static double get certChipGap => 9.5.w;
  static double get certChipHeight => 20.h;
  static double get certChipPaddingH => 8.5.w;
  static double get certChipPaddingIconLeft => 6.w;
  static double get certChipRadius => 6.r;
  static double get certChipIcon => 12.r;
  static double get certChipIconGap => 1.w;
  static double get certTileGap => 12.w;
  static double get certTileHeight => 139.h;
  static double get certTilePaddingH => 12.w;
  static double get certTilePaddingTop => 16.h;
  static double get certTileIconBox => 40.r;
  static double get certTileIcon => 20.r;
  static double get certTileIconTitleGap => 8.5.h;
  static double get certTileTitleHintGap => 8.5.h;
  static double get writeInPadding => 16.r;
  static double get writeInGap => 12.h;
  static double get writeInInputHeight => 43.h;
  static double get writeInInputPaddingH => 14.w;
  static double get writeInButtonHeight => 40.h;
}
