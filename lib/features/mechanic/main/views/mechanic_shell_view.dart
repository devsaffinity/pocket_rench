import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/widgets/app_bottom_nav_bar.dart';
import 'package:pocketwrench/features/mechanic/home/views/mechanic_home_tab.dart';
import 'package:pocketwrench/features/mechanic/main/view_models/mechanic_shell_view_model.dart';
import 'package:pocketwrench/features/mechanic/requests/views/service_requests_tab.dart';
import 'package:pocketwrench/features/shared/alerts/views/alerts_tab.dart';
import 'package:pocketwrench/features/shared/messages/views/messages_tab.dart';
import 'package:pocketwrench/features/shared/profile/views/profile_tab.dart';
import 'package:pocketwrench/features/shared/shell/views/tab_shell.dart';

/// The mechanic's signed-in frame: Home, Requests, Messages, Alerts, Profile.
class MechanicShellView extends StatelessWidget {
  const MechanicShellView({super.key});

  static const List<AppNavItem> _items = [
    AppNavItem(iconPath: AppIcons.navHome, label: AppStrings.navHome),
    AppNavItem(iconPath: AppIcons.navRequests, label: AppStrings.navRequests),
    AppNavItem(iconPath: AppIcons.navMessages, label: AppStrings.navMessages),
    AppNavItem(iconPath: AppIcons.bell, label: AppStrings.navAlerts),
    AppNavItem(iconPath: AppIcons.navProfile, label: AppStrings.navProfile),
  ];

  static const List<Widget> _tabs = [
    MechanicHomeTab(),
    ServiceRequestsTab(),
    MessagesTab(
      emptyBody: AppStrings.mechanicNoMessagesBody,
      emptyActionLabel: AppStrings.browseRequests,
    ),
    AlertsTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) =>
      const TabShell<MechanicShellViewModel>(items: _items, tabs: _tabs);
}
