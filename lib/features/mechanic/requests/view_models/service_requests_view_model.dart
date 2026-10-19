import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/mechanic/requests/data/models/service_request.dart';
import 'package:pocketwrench/features/mechanic/requests/data/repositories/service_request_repository.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_args.dart';
import 'package:pocketwrench/features/shared/messages/data/models/support_request.dart';

/// The three tabs of the mechanic's Service Requests screen. "All" lists the
/// requests still waiting for an answer.
enum ServiceFilter { all, active, resolved }

/// The mechanic's Requests tab.
class ServiceRequestsViewModel extends GetxController {
  ServiceRequestsViewModel(
    this._repository, {
    required VoidCallback onBack,
    required VoidCallback onChanged,
  }) : _onBack = onBack,
       _onChanged = onChanged;

  final ServiceRequestRepository _repository;
  final VoidCallback _onBack;

  /// Tells the rest of the app (Home) that a response was sent.
  final VoidCallback _onChanged;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  List<ServiceRequest> _requests = const [];

  ServiceFilter _filter = ServiceFilter.all;
  ServiceFilter get filter => _filter;

  final Set<String> _responding = {};
  bool isResponding(String id) => _responding.contains(id);

  List<ServiceRequest> _withStatus(ServiceStatus status) =>
      _requests.where((r) => r.status == status).toList();

  int get pendingCount => _withStatus(ServiceStatus.pending).length;

  List<ServiceRequest> get visibleRequests => switch (_filter) {
    ServiceFilter.all => _withStatus(ServiceStatus.pending),
    ServiceFilter.active => _withStatus(ServiceStatus.active),
    ServiceFilter.resolved => _withStatus(ServiceStatus.resolved),
  };

  @override
  void onInit() {
    super.onInit();
    unawaited(load());
  }

  Future<void> load() async {
    _state = ViewState.loading;
    update([AppUpdateIds.serviceRequestsList]);
    try {
      _requests = await _repository.loadRequests();
      _state = ViewState.success;
    } catch (_) {
      _state = ViewState.error;
    }
    update([AppUpdateIds.serviceRequestsList]);
  }

  void selectFilter(ServiceFilter filter) {
    if (filter == _filter) return;
    _filter = filter;
    update([AppUpdateIds.serviceRequestsList]);
  }

  Future<void> onAccept(ServiceRequest request) =>
      _respond(request, accept: true);

  Future<void> onDecline(ServiceRequest request) =>
      _respond(request, accept: false);

  Future<void> _respond(ServiceRequest request, {required bool accept}) async {
    if (!_responding.add(request.id)) return;
    try {
      await _repository.respond(request.id, accept: accept);
      AppSnackbar.show(
        accept ? AppStrings.requestAccepted : AppStrings.requestDeclined,
        type: AppSnackbarType.success,
      );
      _onChanged();
    } catch (_) {
      AppSnackbar.show(AppStrings.genericError, type: AppSnackbarType.error);
    } finally {
      _responding.remove(request.id);
    }
    await load();
  }

  Future<void> onRequestTap(ServiceRequest request) async {
    await Get.toNamed<void>(
      AppRoutes.serviceRequestDetail,
      arguments: request.id,
    );
    await load();
  }

  Future<void> onOpenConversation(ServiceRequest request) async {
    await Get.toNamed<void>(
      AppRoutes.chat,
      arguments: ChatArgs.customer(
        customerId: request.requesterId,
        customerName: request.requesterName,
        request: SupportRequest(
          id: request.id,
          title: request.title,
          details: request.request.shortSummary,
        ),
      ),
    );
  }

  void onBack() => _onBack();
}
