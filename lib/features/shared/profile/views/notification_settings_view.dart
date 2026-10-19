import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_switch.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/features/shared/profile/view_models/notification_settings_view_model.dart';
import 'package:pocketwrench/features/shared/profile/view_models/profile_menu.dart';

/// Notifications: one switch per event, saved together.
class NotificationSettingsView extends GetView<NotificationSettingsViewModel> {
  const NotificationSettingsView({super.key});

  static const List<_NotificationItem> _mechanicItems = [
    _NotificationItem(
      NotificationKind.chatMessages,
      AppStrings.mechNotifyMessageTitle,
      AppStrings.mechNotifyMessageBody,
    ),
    _NotificationItem(
      NotificationKind.liveInvites,
      AppStrings.mechNotifyLiveTitle,
      AppStrings.mechNotifyLiveBody,
    ),
    _NotificationItem(
      NotificationKind.requestResolved,
      AppStrings.notifyResolvedTitle,
      AppStrings.mechNotifyResolvedBody,
    ),
    _NotificationItem(
      NotificationKind.responseHelpful,
      AppStrings.mechNotifyHelpfulTitle,
      AppStrings.mechNotifyHelpfulBody,
    ),
  ];

  static const List<_NotificationItem> _requesterItems = [
    _NotificationItem(
      NotificationKind.responses,
      AppStrings.notifyResponsesTitle,
      AppStrings.notifyResponsesBody,
    ),
    _NotificationItem(
      NotificationKind.chatMessages,
      AppStrings.notifyChatTitle,
      AppStrings.notifyChatBody,
    ),
    _NotificationItem(
      NotificationKind.liveInvites,
      AppStrings.notifyLiveTitle,
      AppStrings.notifyLiveBody,
    ),
    _NotificationItem(
      NotificationKind.requestResolved,
      AppStrings.notifyResolvedTitle,
      AppStrings.notifyResolvedBody,
    ),
    _NotificationItem(
      NotificationKind.responseHelpful,
      AppStrings.notifyHelpfulTitle,
      AppStrings.notifyHelpfulBody,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final items = controller.audience == ProfileAudience.mechanic
        ? _mechanicItems
        : _requesterItems;

    return FlowScaffold(
      title: AppStrings.notificationsTitle,
      titleTop: AppSizes.authTitleTopRole,
      bodyTopGap: AppSizes.settingsGapBelowTitleLoose,
      bottomPadding: AppSizes.settingsBottomPadding,
      onBack: controller.onBack,
      body: GetBuilder<NotificationSettingsViewModel>(
        id: AppUpdateIds.notificationPrefs,
        builder: (vm) => Container(
          padding: EdgeInsets.only(
            top: AppSizes.notifyCardPaddingTop,
            bottom: AppSizes.notifyCardPaddingBottom,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSizes.radiusL),
          ),
          child: Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.notifyRowPaddingH,
                    ),
                    child: const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.border,
                    ),
                  ),
                _NotificationRow(
                  item: items[i],
                  value: vm.isOn(items[i].kind),
                  onChanged: (on) => vm.toggle(items[i].kind, on),
                ),
              ],
            ],
          ),
        ),
      ),
      bottom: GetBuilder<NotificationSettingsViewModel>(
        id: AppUpdateIds.notificationSubmit,
        builder: (vm) => AppButton(
          label: AppStrings.saveChanges,
          height: AppSizes.buttonHeightTall,
          isLoading: vm.isSaving,
          onPressed: vm.onSave,
        ),
      ),
    );
  }
}

class _NotificationItem {
  const _NotificationItem(this.kind, this.title, this.body);

  final NotificationKind kind;
  final String title;
  final String body;
}

class _NotificationRow extends StatelessWidget {
  const _NotificationRow({
    required this.item,
    required this.value,
    required this.onChanged,
  });

  final _NotificationItem item;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.notifyRowPaddingH,
        vertical: AppSizes.notifyRowPaddingV,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: AppTextStyles.notifyTitle),
                SizedBox(height: AppSizes.notifyTitleBodyGap),
                Text(item.body, style: AppTextStyles.notifyBody),
              ],
            ),
          ),
          SizedBox(width: AppSizes.notifyTextSwitchGap),
          AppSwitch(
            value: value,
            onChanged: onChanged,
            width: AppSizes.notifySwitchWidth,
            knobSize: AppSizes.notifySwitchKnob,
            inset: AppSizes.notifySwitchInset,
            activeColor: AppColors.accent,
            inactiveColor: AppColors.surface,
            knobColor: AppColors.textMuted,
          ),
        ],
      ),
    );
  }
}
