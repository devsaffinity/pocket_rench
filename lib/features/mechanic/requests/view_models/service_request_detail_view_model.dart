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

/// One request in full, with the actions that fit where it stands.
class ServiceRequestDetailViewModel extends GetxController {
  ServiceRequestDetailViewModel(
    this._repository, {
    required VoidCallback onChanged,
  }) : _onChanged = onChanged;

  final ServiceRequestRepository _repository;
  final VoidCallback _onChanged;

  String? _id;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  ServiceRequest? _request;
  ServiceRequest? get request => _request;

  bool _isResponding = false;
  bool get isResponding => _isResponding;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is String) _id = arguments;
    unawaited(load());
  }

  Future<void> load() async {
    final id = _id;
    if (id == null) {
      _state = ViewState.error;
      update([AppUpdateIds.serviceRequestDetail]);
      return;
    }

    _state = ViewState.loading;
    update([AppUpdateIds.serviceRequestDetail]);
    try {
      _request = await _repository.loadRequest(id);
      _state = ViewState.success;
    } catch (_) {
      _state = ViewState.error;
    }
    update([AppUpdateIds.serviceRequestDetail]);
  }

  Future<void> onAccept() => _respond(accept: true);

  Future<void> onDecline() => _respond(accept: false);

  Future<void> _respond({required bool accept}) async {
    final current = _request;
    if (current == null || _isResponding) return;

    _isResponding = true;
    update([AppUpdateIds.serviceRequestDetail]);
    try {
      await _repository.respond(current.id, accept: accept);
    } catch (_) {
      _isResponding = false;
      update([AppUpdateIds.serviceRequestDetail]);
      AppSnackbar.show(AppStrings.genericError, type: AppSnackbarType.error);
      return;
    }

    _onChanged();
    // Leave first: Get.back() would close an open snackbar instead.
    Get.back<void>();
    AppSnackbar.show(
      accept ? AppStrings.requestAccepted : AppStrings.requestDeclined,
      type: AppSnackbarType.success,
    );
  }

  Future<void> onOpenConversation() async {
    final current = _request;
    if (current == null) return;
    await Get.toNamed<void>(
      AppRoutes.chat,
      arguments: ChatArgs.customer(
        customerId: current.requesterId,
        customerName: current.requesterName,
        request: SupportRequest(
          id: current.id,
          title: current.title,
          details: current.request.shortSummary,
        ),
      ),
    );
  }

  void onBack() => Get.back<void>();
}
