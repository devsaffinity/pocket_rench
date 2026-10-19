import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/mechanic/home/data/models/mechanic_home_data.dart';
import 'package:pocketwrench/features/mechanic/home/data/repositories/mechanic_home_repository.dart';
import 'package:pocketwrench/features/mechanic/requests/data/models/service_request.dart';
import 'package:pocketwrench/features/mechanic/requests/data/repositories/service_request_repository.dart';
import 'package:pocketwrench/features/shared/profile/data/models/account.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';

/// The mechanic's Home tab: who is signed in, how they are doing, and the
/// requests waiting for an answer.
class MechanicHomeViewModel extends GetxController {
  MechanicHomeViewModel(
    this._repository,
    this._requestRepository,
    this._accountRepository, {
    required VoidCallback onOpenRequests,
    required VoidCallback onRequestsChanged,
  }) : _onOpenRequests = onOpenRequests,
       _onRequestsChanged = onRequestsChanged;

  final MechanicHomeRepository _repository;
  final ServiceRequestRepository _requestRepository;
  final AccountRepository _accountRepository;
  final VoidCallback _onOpenRequests;

  /// Tells the Requests tab that a response was sent from here.
  final VoidCallback _onRequestsChanged;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  Account? _account;
  Account? get account => _account;

  MechanicHomeData? _data;
  MechanicHomeData? get data => _data;

  List<ServiceRequest> _requests = const [];

  /// Requests still waiting for an answer.
  List<ServiceRequest> get requests => _requests;

  final Set<String> _responding = {};

  bool isResponding(String id) => _responding.contains(id);

  @override
  void onInit() {
    super.onInit();
    unawaited(load());
  }

  Future<void> load() async {
    _state = ViewState.loading;
    update([AppUpdateIds.mechanicHomeBody]);
    try {
      _account = await _accountRepository.loadAccount();
      _data = await _repository.loadHome();
      final all = await _requestRepository.loadRequests();
      _requests = all.where((r) => r.status == ServiceStatus.pending).toList();
      _state = ViewState.success;
    } catch (_) {
      _state = ViewState.error;
    }
    update([AppUpdateIds.mechanicHomeBody]);
  }

  Future<void> onAccept(ServiceRequest request) =>
      _respond(request, accept: true);

  Future<void> onDecline(ServiceRequest request) =>
      _respond(request, accept: false);

  Future<void> _respond(ServiceRequest request, {required bool accept}) async {
    if (!_responding.add(request.id)) return;
    try {
      await _requestRepository.respond(request.id, accept: accept);
      _requests = [
        for (final r in _requests)
          if (r.id != request.id) r,
      ];
      _onRequestsChanged();
      AppSnackbar.show(
        accept ? AppStrings.requestAccepted : AppStrings.requestDeclined,
        type: AppSnackbarType.success,
      );
    } catch (_) {
      AppSnackbar.show(AppStrings.genericError, type: AppSnackbarType.error);
    } finally {
      _responding.remove(request.id);
      update([AppUpdateIds.mechanicHomeBody]);
    }
  }

  Future<void> onRequestTap(ServiceRequest request) async {
    await Get.toNamed<void>(
      AppRoutes.serviceRequestDetail,
      arguments: request.id,
    );
    await load();
  }

  void onSeeAll() => _onOpenRequests();

  // Notifications and plans are not designed yet.
  void onBellTap() => AppSnackbar.show(AppStrings.featureComingSoon);
  void onUpgrade() => AppSnackbar.show(AppStrings.featureComingSoon);
}
