import 'dart:async';

import 'package:get/get.dart';
import 'package:pocketwrench/features/mechanic/home/data/repositories/mechanic_home_repository.dart';
import 'package:pocketwrench/features/mechanic/home/data/repositories/mock_mechanic_home_repository.dart';
import 'package:pocketwrench/features/mechanic/home/view_models/mechanic_home_view_model.dart';
import 'package:pocketwrench/features/mechanic/main/view_models/mechanic_shell_view_model.dart';
import 'package:pocketwrench/features/mechanic/profile/data/repositories/mechanic_profile_repository.dart';
import 'package:pocketwrench/features/mechanic/profile/data/repositories/mock_mechanic_profile_repository.dart';
import 'package:pocketwrench/features/mechanic/profile/view_models/mechanic_profile_menu_view_model.dart';
import 'package:pocketwrench/features/mechanic/requests/data/repositories/mock_service_request_repository.dart';
import 'package:pocketwrench/features/mechanic/requests/data/repositories/service_request_repository.dart';
import 'package:pocketwrench/features/mechanic/requests/view_models/service_requests_view_model.dart';
import 'package:pocketwrench/features/shared/alerts/data/repositories/alerts_repository.dart';
import 'package:pocketwrench/features/shared/alerts/data/repositories/mock_alerts_repository.dart';
import 'package:pocketwrench/features/shared/alerts/view_models/alerts_view_model.dart';
import 'package:pocketwrench/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_perspective.dart';
import 'package:pocketwrench/features/shared/messages/data/repositories/message_repository.dart';
import 'package:pocketwrench/features/shared/messages/data/repositories/mock_message_repository.dart';
import 'package:pocketwrench/features/shared/messages/view_models/messages_view_model.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/mock_account_repository.dart';
import 'package:pocketwrench/features/shared/profile/view_models/profile_view_model.dart';

/// Dependencies for the mechanic's signed-in shell and the tabs it hosts.
class MechanicMainBinding extends Bindings {
  void _openTab(int index) =>
      Get.find<MechanicShellViewModel>().selectTab(index);

  @override
  void dependencies() {
    // The sample account is the mechanic's, not the requester's.
    final accounts = Get.find<AccountRepository>();
    if (accounts is MockAccountRepository) accounts.useMechanicAccount();
    final messages = Get.find<MessageRepository>();
    if (messages is MockMessageRepository) messages.useMechanicData();
    // Created now, not on first use: the pushed profile screens read it and
    // are disposed on pop, which would take a lazily created copy with them.
    Get.put<MechanicProfileRepository>(MockMechanicProfileRepository());
    Get.lazyPut<MechanicHomeRepository>(MockMechanicHomeRepository.new);
    Get.lazyPut<MechanicShellViewModel>(MechanicShellViewModel.new);
    Get.lazyPut<ServiceRequestRepository>(MockServiceRequestRepository.new);
    Get.lazyPut<MechanicHomeViewModel>(
      () => MechanicHomeViewModel(
        Get.find<MechanicHomeRepository>(),
        Get.find<ServiceRequestRepository>(),
        Get.find<AccountRepository>(),
        onOpenRequests: () => _openTab(MechanicShellViewModel.requestsTab),
        onRequestsChanged: () =>
            unawaited(Get.find<ServiceRequestsViewModel>().load()),
      ),
    );
    Get.lazyPut<ServiceRequestsViewModel>(
      () => ServiceRequestsViewModel(
        Get.find<ServiceRequestRepository>(),
        onBack: () => _openTab(MechanicShellViewModel.homeTab),
        onChanged: () => unawaited(Get.find<MechanicHomeViewModel>().load()),
      ),
    );
    Get.lazyPut<MessagesViewModel>(
      () => MessagesViewModel(
        Get.find<MessageRepository>(),
        perspective: ChatPerspective.mechanic,
        onBack: () => _openTab(MechanicShellViewModel.homeTab),
        onEmptyAction: () => _openTab(MechanicShellViewModel.requestsTab),
      ),
    );
    Get.lazyPut<AlertsRepository>(MockAlertsRepository.new);
    Get.lazyPut<AlertsViewModel>(
      () => AlertsViewModel(
        Get.find<AlertsRepository>(),
        onBack: () => _openTab(MechanicShellViewModel.homeTab),
      ),
    );
    // The Profile tab looks up its ViewModel as the shared base type.
    Get.lazyPut<ProfileViewModel>(
      () => MechanicProfileMenuViewModel(
        Get.find<AccountRepository>(),
        Get.find<AuthRepository>(),
        onBack: () => _openTab(MechanicShellViewModel.homeTab),
        onAccountChanged: () =>
            unawaited(Get.find<MechanicHomeViewModel>().load()),
      ),
    );
  }
}
