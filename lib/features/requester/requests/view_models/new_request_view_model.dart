import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/utils/validators.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/requester/requests/data/models/request_draft.dart';
import 'package:pocketwrench/features/requester/requests/data/models/vehicle_catalog.dart';
import 'package:pocketwrench/features/requester/requests/data/repositories/attachment_picker.dart';
import 'package:pocketwrench/features/requester/requests/data/repositories/request_repository.dart';
import 'package:pocketwrench/features/shared/requests/data/models/help_request.dart';

/// State shared by the three "new request" steps: details, files and review.
class NewRequestViewModel extends GetxController {
  NewRequestViewModel(this._repository, this._picker);

  static const Duration _uploadStep = Duration(milliseconds: 250);
  static const double _uploadIncrement = 0.12;

  final RequestRepository _repository;
  final AttachmentPicker _picker;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  RequestDraft _draft = const RequestDraft();
  RequestDraft get draft => _draft;

  String? _titleError;
  String? get titleError => _titleError;
  String? _categoryError;
  String? get categoryError => _categoryError;
  String? _makeError;
  String? get makeError => _makeError;
  String? _modelError;
  String? get modelError => _modelError;
  String? _yearError;
  String? get yearError => _yearError;

  bool _isSending = false;
  bool get isSending => _isSending;

  Timer? _uploadTimer;

  /// Models offered for the chosen make.
  List<VehicleModel> get availableModels =>
      VehicleCatalog.modelsByMake[_draft.make] ?? const [];

  @override
  void onClose() {
    _uploadTimer?.cancel();
    AppHelpers.disposeAfterFrame([titleController, descriptionController]);
    super.onClose();
  }

  // Step 1: details

  void onTitleChanged(String value) {
    _draft = _draft.copyWith(title: value);
    if (_titleError == null) return;
    _titleError = null;
    update([AppUpdateIds.requestTitleField]);
  }

  void onDescriptionChanged(String value) {
    _draft = _draft.copyWith(description: value);
  }

  void selectCategory(String category) {
    _draft = _draft.copyWith(category: category);
    _categoryError = null;
    update([AppUpdateIds.requestCategoryField]);
  }

  void selectMake(String make) {
    if (make == _draft.make) return;
    _draft = _draft.copyWith(make: make, clearModel: true);
    _makeError = null;
    update([AppUpdateIds.requestVehicleField]);
  }

  void selectModel(VehicleModel model) {
    _draft = _draft.copyWith(model: model.name, engine: model.engine);
    _modelError = null;
    update([AppUpdateIds.requestVehicleField]);
  }

  void selectYear(int year) {
    _draft = _draft.copyWith(year: year);
    _yearError = null;
    update([AppUpdateIds.requestVehicleField]);
  }

  void selectUrgency(RequestUrgency urgency) {
    _draft = _draft.copyWith(urgency: urgency);
    update([AppUpdateIds.requestUrgencyField]);
  }

  bool _validateDetails() {
    _titleError = Validators.required(_draft.title);
    _categoryError = _draft.category == null
        ? AppStrings.selectionRequired
        : null;
    _makeError = _draft.make == null ? AppStrings.selectionRequired : null;
    _modelError = _draft.model == null ? AppStrings.selectionRequired : null;
    _yearError = _draft.year == null ? AppStrings.selectionRequired : null;
    update([
      AppUpdateIds.requestTitleField,
      AppUpdateIds.requestCategoryField,
      AppUpdateIds.requestVehicleField,
    ]);
    return _titleError == null &&
        _categoryError == null &&
        _makeError == null &&
        _modelError == null &&
        _yearError == null;
  }

  Future<void> onNextFromDetails() async {
    AppHelpers.unfocus();
    if (!_validateDetails()) return;
    await Get.toNamed<void>(AppRoutes.newRequestFiles);
  }

  // Step 2: files

  Future<void> pickAttachment(AttachmentSource source) async {
    final attachment = await _picker.pick(source);
    if (attachment == null) return;

    _draft = _draft.copyWith(attachments: [..._draft.attachments, attachment]);
    update([AppUpdateIds.requestAttachments]);
    _startUploads();
  }

  void removeAttachment(String id) {
    _draft = _draft.copyWith(
      attachments: _draft.attachments.where((a) => a.id != id).toList(),
    );
    update([AppUpdateIds.requestAttachments]);
  }

  /// Advances every unfinished upload until none is left. The progress is
  /// simulated: a real implementation reports it from the upload.
  void _startUploads() {
    _uploadTimer ??= Timer.periodic(_uploadStep, (timer) {
      var anyUploading = false;
      _draft = _draft.copyWith(
        attachments: [
          for (final attachment in _draft.attachments)
            if (attachment.isUploading)
              () {
                final next = (attachment.progress + _uploadIncrement).clamp(
                  0.0,
                  1.0,
                );
                if (next < 1) anyUploading = true;
                return attachment.copyWith(progress: next);
              }()
            else
              attachment,
        ],
      );
      update([AppUpdateIds.requestAttachments]);
      if (!anyUploading) {
        timer.cancel();
        _uploadTimer = null;
      }
    });
  }

  Future<void> onNextFromFiles() async {
    await Get.toNamed<void>(AppRoutes.newRequestReview);
  }

  // Step 3: review

  /// Back to the details step, from the review step.
  void onEditDetails() =>
      Get.until((route) => route.settings.name == AppRoutes.newRequestDetails);

  void onViewDescription() => Get.toNamed<void>(AppRoutes.requestDescription);

  void onEditFiles() => Get.back<void>();

  Future<void> onSend() async {
    if (_isSending || !_draft.isComplete) return;

    _isSending = true;
    update([AppUpdateIds.requestSubmit]);
    try {
      await _repository.submit(_draft);
    } catch (_) {
      _isSending = false;
      update([AppUpdateIds.requestSubmit]);
      AppSnackbar.show(AppStrings.genericError, type: AppSnackbarType.error);
      return;
    }
    _isSending = false;
    update([AppUpdateIds.requestSubmit]);

    // Replace the three steps with the confirmation, keeping the main shell.
    await Get.offNamedUntil<void>(
      AppRoutes.requestSubmitted,
      (route) => route.settings.name == AppRoutes.main,
    );
  }

  void onBack() => Get.back<void>();
}
