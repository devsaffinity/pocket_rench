import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/theme/app_system_ui.dart';
import 'package:pocketwrench/core/widgets/app_bottom_nav_bar.dart';
import 'package:pocketwrench/features/shared/shell/view_models/tab_shell_view_model.dart';

/// Signed-in frame shared by both roles: a Scaffold whose body is the selected
/// tab and whose bottom bar switches between tabs. Tabs stay alive while
/// hidden. [T] is the role's shell ViewModel, registered by its binding.
class TabShell<T extends TabShellViewModel> extends StatelessWidget {
  const TabShell({required this.items, required this.tabs, super.key});

  final List<AppNavItem> items;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    assert(items.length == tabs.length, 'One body per navigation item');
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.lightIconsOnSurface,
      child: Scaffold(
        body: GetBuilder<T>(
          id: AppUpdateIds.navBody,
          builder: (vm) => IndexedStack(index: vm.currentIndex, children: tabs),
        ),
        bottomNavigationBar: GetBuilder<T>(
          id: AppUpdateIds.navBar,
          builder: (vm) => AppBottomNavBar(
            items: items,
            currentIndex: vm.currentIndex,
            onChanged: vm.selectTab,
          ),
        ),
      ),
    );
  }
}
