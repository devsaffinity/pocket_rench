import 'dart:async';

import 'package:get/get.dart';
import 'package:pocketwrench/features/requester/explore/view_models/explore_view_model.dart';
import 'package:pocketwrench/features/requester/home/data/repositories/home_repository.dart';
import 'package:pocketwrench/features/requester/home/data/repositories/mock_home_repository.dart';
import 'package:pocketwrench/features/requester/home/view_models/home_view_model.dart';
import 'package:pocketwrench/features/requester/main/view_models/main_shell_view_model.dart';
import 'package:pocketwrench/features/requester/mechanics/data/repositories/mechanic_repository.dart';
import 'package:pocketwrench/features/requester/requests/data/repositories/request_repository.dart';
import 'package:pocketwrench/features/requester/requests/view_models/requests_view_model.dart';
import 'package:pocketwrench/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:pocketwrench/features/shared/messages/data/repositories/message_repository.dart';
import 'package:pocketwrench/features/shared/messages/data/repositories/mock_message_repository.dart';
import 'package:pocketwrench/features/shared/messages/view_models/messages_view_model.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/mock_account_repository.dart';
import 'package:pocketwrench/features/shared/profile/view_models/profile_view_model.dart';

/// Dependencies for the signed-in shell and the tabs it hosts. Tabs ask the
/// shell to switch tabs through callbacks, so they never reference each other.
class MainBinding extends Bindings {
  void _openTab(int index) => Get.find<MainShellViewModel>().selectTab(index);

  @override
  void dependencies() {
    // The mocks are shared by both roles; make sure they serve the requester's.
    final accounts = Get.find<AccountRepository>();
    if (accounts is MockAccountRepository) accounts.useRequesterAccount();
    final messages = Get.find<MessageRepository>();
    if (messages is MockMessageRepository) messages.useRequesterData();

    Get.lazyPut<HomeRepository>(MockHomeRepository.new);
    Get.lazyPut<MainShellViewModel>(MainShellViewModel.new);
    Get.lazyPut<HomeViewModel>(
      () => HomeViewModel(
        Get.find<HomeRepository>(),
        Get.find<RequestRepository>(),
        Get.find<AccountRepository>(),
        onOpenExplore: () => _openTab(MainShellViewModel.exploreTab),
        onOpenRequests: () => _openTab(MainShellViewModel.requestsTab),
      ),
    );
    Get.lazyPut<RequestsViewModel>(
      () => RequestsViewModel(
        Get.find<RequestRepository>(),
        onBack: () => _openTab(MainShellViewModel.homeTab),
      ),
    );
    Get.lazyPut<ExploreViewModel>(
      () => ExploreViewModel(
        Get.find<MechanicRepository>(),
        onBack: () => _openTab(MainShellViewModel.homeTab),
      ),
    );
    Get.lazyPut<ProfileViewModel>(
      () => ProfileViewModel(
        Get.find<AccountRepository>(),
        Get.find<AuthRepository>(),
        onBack: () => _openTab(MainShellViewModel.homeTab),
        onAccountChanged: () => unawaited(Get.find<HomeViewModel>().load()),
      ),
    );
    Get.lazyPut<MessagesViewModel>(
      () => MessagesViewModel(
        Get.find<MessageRepository>(),
        onBack: () => _openTab(MainShellViewModel.homeTab),
        onEmptyAction: () => _openTab(MainShellViewModel.exploreTab),
      ),
    );
  }
}
