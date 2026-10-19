import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/widgets/app_bottom_nav_bar.dart';
import 'package:pocketwrench/features/requester/explore/views/explore_tab.dart';
import 'package:pocketwrench/features/requester/home/views/home_tab.dart';
import 'package:pocketwrench/features/requester/main/view_models/main_shell_view_model.dart';
import 'package:pocketwrench/features/requester/requests/views/requests_tab.dart';
import 'package:pocketwrench/features/shared/messages/views/messages_tab.dart';
import 'package:pocketwrench/features/shared/profile/views/profile_tab.dart';
import 'package:pocketwrench/features/shared/shell/views/tab_shell.dart';

/// The requester's signed-in frame: Home, Requests, Explore, Messages, Profile.
class MainShellView extends StatelessWidget {
  const MainShellView({super.key});

  static const List<AppNavItem> _items = [
    AppNavItem(iconPath: AppIcons.navHome, label: AppStrings.navHome),
    AppNavItem(iconPath: AppIcons.navRequests, label: AppStrings.navRequests),
    AppNavItem(iconPath: AppIcons.search, label: AppStrings.navExplore),
    AppNavItem(iconPath: AppIcons.navMessages, label: AppStrings.navMessages),
    AppNavItem(iconPath: AppIcons.navProfile, label: AppStrings.navProfile),
  ];

  static const List<Widget> _tabs = [
    HomeTab(),
    RequestsTab(),
    ExploreTab(),
    MessagesTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) =>
      const TabShell<MainShellViewModel>(items: _items, tabs: _tabs);
}
