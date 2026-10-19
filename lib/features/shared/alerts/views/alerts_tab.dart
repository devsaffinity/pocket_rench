import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/utils/extensions.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_empty_state.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';
import 'package:pocketwrench/core/widgets/app_loader.dart';
import 'package:pocketwrench/core/widgets/app_text.dart';
import 'package:pocketwrench/core/widgets/fade_slide_in.dart';
import 'package:pocketwrench/features/shared/alerts/data/models/alert_item.dart';
import 'package:pocketwrench/features/shared/alerts/view_models/alerts_view_model.dart';
import 'package:pocketwrench/features/shared/alerts/views/widgets/alert_card.dart';

/// Alerts tab body. Hosted by a role's shell, which provides the navigation
/// bar.
class AlertsTab extends GetView<AlertsViewModel> {
  const AlertsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final topShift = math.max(
      0.0,
      context.topInset + AppSizes.spaceS - AppSizes.authLogoTop,
    );

    return Stack(
      children: [
        SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.only(
            top: AppSizes.authTitleTopRole + topShift,
            left: AppSizes.screenPaddingH,
            right: AppSizes.screenPaddingH,
            bottom: AppSizes.homeBottomPadding,
          ),
          child: FadeSlideIn(
            child: GetBuilder<AlertsViewModel>(
              id: AppUpdateIds.alertsList,
              builder: (vm) => _Content(viewModel: vm),
            ),
          ),
        ),
        Positioned(
          left: AppSizes.authBackLeft,
          top: AppSizes.authBackTop + topShift,
          child: AppIconButton(
            svgPath: AppIcons.arrowLeft,
            size: AppSizes.iconBack,
            onPressed: controller.onBack,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.viewModel});

  final AlertsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (viewModel.state == ViewState.error) {
      body = AppEmptyState(
        title: AppStrings.genericError,
        actionLabel: AppStrings.retry,
        onAction: viewModel.load,
      );
    } else if (viewModel.state != ViewState.success) {
      body = Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.spaceXL),
        child: const Center(child: AppLoader()),
      );
    } else if (viewModel.isEmpty) {
      body = const AppEmptyState(
        title: AppStrings.noAlertsTitle,
        message: AppStrings.noAlertsMessage,
      );
    } else {
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(
            label: AppStrings.alertsToday,
            alerts: viewModel.today,
            onTap: viewModel.onAlertTap,
          ),
          _Section(
            label: AppStrings.alertsEarlier,
            alerts: viewModel.earlier,
            onTap: viewModel.onAlertTap,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.heading(AppStrings.alertsTitle),
        SizedBox(height: AppSizes.alertTitleSectionGap),
        body,
      ],
    );
  }
}

/// An uppercase label and its cards; renders nothing when there are none.
class _Section extends StatelessWidget {
  const _Section({
    required this.label,
    required this.alerts,
    required this.onTap,
  });

  final String label;
  final List<AlertItem> alerts;
  final ValueChanged<AlertItem> onTap;

  @override
  Widget build(BuildContext context) {
    if (alerts.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.alertSectionGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.profileSection),
          SizedBox(height: AppSizes.alertLabelCardGap),
          for (var i = 0; i < alerts.length; i++) ...[
            if (i > 0) SizedBox(height: AppSizes.alertCardGap),
            AlertCard(alert: alerts[i], onTap: () => onTap(alerts[i])),
          ],
        ],
      ),
    );
  }
}
