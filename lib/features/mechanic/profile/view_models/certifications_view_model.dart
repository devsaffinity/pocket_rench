import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/repositories/document_picker.dart';
import 'package:pocketwrench/features/mechanic/profile/data/models/certification.dart';
import 'package:pocketwrench/features/mechanic/profile/data/repositories/mechanic_profile_repository.dart';

/// The mechanic's certifications: those on file, and ways to add more.
class CertificationsViewModel extends GetxController {
  CertificationsViewModel(this._repository, this._picker);

  final MechanicProfileRepository _repository;
  final DocumentPicker _picker;

  final TextEditingController writeInController = TextEditingController();
  final FocusNode writeInFocus = FocusNode();

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  List<Certification> _certifications = const [];
  List<Certification> get certifications => _certifications;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  @override
  void onInit() {
    super.onInit();
    unawaited(load());
  }

  @override
  void onClose() {
    AppHelpers.disposeAfterFrame([writeInController, writeInFocus]);
    super.onClose();
  }

  Future<void> load() async {
    _state = ViewState.loading;
    update([AppUpdateIds.certificationsList]);
    try {
      _certifications = await _repository.loadCertifications();
      _state = ViewState.success;
    } catch (_) {
      _state = ViewState.error;
    }
    update([AppUpdateIds.certificationsList]);
  }

  /// "Upload Certificate": picks a document and sends it for review.
  Future<void> onUpload() async {
    final document = await _picker.pick();
    if (document == null) return;
    await _submit(document.name);
  }

  /// "Enter Manually": puts the cursor in the write-in field.
  void onEnterManually() => writeInFocus.requestFocus();

  Future<void> onSubmitWriteIn() async {
    final name = writeInController.text.trim();
    if (name.isEmpty) {
      writeInFocus.requestFocus();
      return;
    }
    await _submit(name);
    writeInController.clear();
  }

  Future<void> _submit(String name) async {
    if (_isSubmitting) return;
    _isSubmitting = true;
    update([AppUpdateIds.certificationsList]);
    try {
      await _repository.submitCertification(name);
      _certifications = await _repository.loadCertifications();
      AppSnackbar.show(
        AppStrings.certificationSubmitted,
        type: AppSnackbarType.success,
      );
    } catch (_) {
      AppSnackbar.show(AppStrings.genericError, type: AppSnackbarType.error);
    } finally {
      _isSubmitting = false;
      update([AppUpdateIds.certificationsList]);
    }
  }

  Future<void> remove(Certification certification) async {
    try {
      await _repository.removeCertification(certification.id);
      _certifications = await _repository.loadCertifications();
      update([AppUpdateIds.certificationsList]);
      AppSnackbar.show(
        AppStrings.certificationRemoved,
        type: AppSnackbarType.success,
      );
    } catch (_) {
      AppSnackbar.show(AppStrings.genericError, type: AppSnackbarType.error);
    }
  }

  void onBack() => Get.back<void>();
}
