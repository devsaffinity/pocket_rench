import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/features/shared/alerts/data/models/alert_item.dart';
import 'package:pocketwrench/features/shared/alerts/data/repositories/alerts_repository.dart';

/// The Alerts tab: notifications grouped into Today and Earlier.
class AlertsViewModel extends GetxController {
  AlertsViewModel(this._repository, {required VoidCallback onBack})
    : _onBack = onBack;

  final AlertsRepository _repository;
  final VoidCallback _onBack;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  List<AlertItem> _alerts = const [];
  List<AlertItem> get today => _alerts.where((a) => a.isToday).toList();
  List<AlertItem> get earlier => _alerts.where((a) => !a.isToday).toList();
  bool get isEmpty => _alerts.isEmpty;

  @override
  void onInit() {
    super.onInit();
    unawaited(load());
  }

  Future<void> load() async {
    _state = ViewState.loading;
    update([AppUpdateIds.alertsList]);
    try {
      _alerts = await _repository.loadAlerts();
      _state = ViewState.success;
    } catch (_) {
      _state = ViewState.error;
    }
    update([AppUpdateIds.alertsList]);
  }

  /// Opening an alert marks it read. Where it leads is not designed yet.
  Future<void> onAlertTap(AlertItem alert) async {
    if (!alert.isUnread) return;
    _alerts = [
      for (final a in _alerts)
        if (a.id == alert.id) a.markRead() else a,
    ];
    update([AppUpdateIds.alertsList]);
    await _repository.markRead(alert.id);
  }

  void onBack() => _onBack();
}
