import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';

/// Which bottom-navigation tab is showing. Each role's shell extends this
/// with its own tab indexes.
class TabShellViewModel extends GetxController {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void selectTab(int index) {
    if (index == _currentIndex) return;
    _currentIndex = index;
    update([AppUpdateIds.navBar, AppUpdateIds.navBody]);
  }
}
