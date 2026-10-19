import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/models/chip_option.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/models/mechanic_onboarding_draft.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/models/onboarding_catalog.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/models/uploaded_document.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/repositories/document_picker.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/repositories/mechanic_onboarding_repository.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';

/// State shared by the five mechanic onboarding screens: experience, vehicles,
/// expertise, verification and the confirmation.
class MechanicOnboardingViewModel extends GetxController {
  MechanicOnboardingViewModel(
    this._repository,
    this._accountRepository,
    this._documentPicker,
  );

  final MechanicOnboardingRepository _repository;
  final AccountRepository _accountRepository;
  final DocumentPicker _documentPicker;

  // Step 1: experience

  String? _trade;
  String? get trade => _trade;
  String? _years;
  String? get years => _years;
  String? _city;
  String? get city => _city;
  final Set<String> _specialties = {};
  Set<String> get specialties => _specialties;

  List<String> _cities = const [];
  List<String> get cities => _cities;

  String? _tradeError;
  String? get tradeError => _tradeError;
  String? _yearsError;
  String? get yearsError => _yearsError;
  String? _cityError;
  String? get cityError => _cityError;
  String? _specialtiesError;
  String? get specialtiesError => _specialtiesError;

  // Step 2: vehicles

  final TextEditingController brandSearchController = TextEditingController();
  final Set<String> _brands = {};
  Set<String> get brands => _brands;

  List<ChipOption> get visibleBrands {
    final query = brandSearchController.text.trim().toLowerCase();
    if (query.isEmpty) return OnboardingCatalog.brands;
    return OnboardingCatalog.brands
        .where((brand) => brand.label.toLowerCase().contains(query))
        .toList();
  }

  // Step 3: expertise

  final Set<String> _certifications = {};
  Set<String> get certifications => _certifications;
  final List<ChipOption> _customCertifications = [];

  /// The listed certifications followed by any the mechanic typed in.
  List<ChipOption> get certificationOptions => [
    ...OnboardingCatalog.certifications,
    ..._customCertifications,
  ];

  final Set<String> _skills = {};
  Set<String> get skills => _skills;

  final TextEditingController customCertificationController =
      TextEditingController();
  final TextEditingController standardPriceController = TextEditingController(
    text: _formatPrice(OnboardingCatalog.standardPrice),
  );
  final TextEditingController urgentPriceController = TextEditingController(
    text: _formatPrice(OnboardingCatalog.urgentPrice),
  );
  final TextEditingController livePriceController = TextEditingController(
    text: _formatPrice(OnboardingCatalog.livePrice),
  );

  // Step 4: verification

  final List<UploadedDocument> _documents = [];
  List<UploadedDocument> get documents => List.unmodifiable(_documents);

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  /// What the confirmation screen lists as submitted: the first certification
  /// chosen, or else the first document's file name.
  String get submittedCertification {
    if (_certifications.isNotEmpty) return _certifications.first;
    if (_documents.isNotEmpty) return _documents.first.name;
    return '';
  }

  static String _formatPrice(int dollars) => '\$$dollars';

  static int? _parsePrice(String text) {
    final digits = text.replaceAll(RegExp(r'[^0-9]'), '');
    final value = int.tryParse(digits);
    return value == null || value <= 0 ? null : value;
  }

  @override
  void onInit() {
    super.onInit();
    unawaited(_loadCities());
  }

  @override
  void onClose() {
    AppHelpers.disposeAfterFrame([
      brandSearchController,
      customCertificationController,
      standardPriceController,
      urgentPriceController,
      livePriceController,
    ]);
    super.onClose();
  }

  Future<void> _loadCities() async {
    _cities = await _accountRepository.loadCities();
    update([AppUpdateIds.onbCity]);
  }

  // Step 1

  void selectTrade(String trade) {
    _trade = trade;
    _tradeError = null;
    update([AppUpdateIds.onbTrade]);
  }

  void selectYears(String years) {
    _years = years;
    _yearsError = null;
    update([AppUpdateIds.onbYears]);
  }

  void selectCity(String city) {
    _city = city;
    _cityError = null;
    update([AppUpdateIds.onbCity]);
  }

  void toggleSpecialty(String specialty) {
    if (!_specialties.add(specialty)) _specialties.remove(specialty);
    _specialtiesError = null;
    update([AppUpdateIds.onbSpecialties]);
  }

  Future<void> onNextFromExperience() async {
    _tradeError = _trade == null ? AppStrings.selectionRequired : null;
    _yearsError = _years == null ? AppStrings.selectionRequired : null;
    _cityError = _city == null ? AppStrings.selectionRequired : null;
    _specialtiesError = _specialties.isEmpty
        ? AppStrings.selectAtLeastOneSpecialty
        : null;
    update([
      AppUpdateIds.onbTrade,
      AppUpdateIds.onbYears,
      AppUpdateIds.onbCity,
      AppUpdateIds.onbSpecialties,
    ]);
    if (_tradeError != null ||
        _yearsError != null ||
        _cityError != null ||
        _specialtiesError != null) {
      return;
    }
    await Get.toNamed<void>(AppRoutes.mechanicVehicles);
  }

  // Step 2

  void onBrandSearchChanged(String _) => update([AppUpdateIds.onbBrands]);

  void toggleBrand(String brand) {
    if (!_brands.add(brand)) _brands.remove(brand);
    update([AppUpdateIds.onbBrands]);
  }

  Future<void> onNextFromVehicles() async {
    if (_brands.isEmpty) {
      AppSnackbar.show(
        AppStrings.selectAtLeastOneBrand,
        type: AppSnackbarType.error,
      );
      return;
    }
    await Get.toNamed<void>(AppRoutes.mechanicExpertise);
  }

  // Step 3

  void toggleCertification(String certification) {
    if (!_certifications.add(certification)) {
      _certifications.remove(certification);
    }
    update([AppUpdateIds.onbCertifications]);
  }

  void toggleSkill(String skill) {
    if (!_skills.add(skill)) _skills.remove(skill);
    update([AppUpdateIds.onbSkills]);
  }

  /// Adds a certification that is not in the list, already selected.
  void onAddCertification() {
    final label = customCertificationController.text.trim();
    if (label.isEmpty) return;

    final exists = certificationOptions.any(
      (option) => option.label.toLowerCase() == label.toLowerCase(),
    );
    if (!exists) _customCertifications.add(ChipOption(label));
    _certifications.add(
      certificationOptions
          .firstWhere((o) => o.label.toLowerCase() == label.toLowerCase())
          .label,
    );
    customCertificationController.clear();
    update([AppUpdateIds.onbCertifications]);
  }

  Future<void> onNextFromExpertise() async {
    final prices = [
      standardPriceController.text,
      urgentPriceController.text,
      livePriceController.text,
    ].map(_parsePrice);
    if (prices.any((price) => price == null)) {
      AppSnackbar.show(AppStrings.enterAllPrices, type: AppSnackbarType.error);
      return;
    }
    await Get.toNamed<void>(AppRoutes.mechanicVerification);
  }

  // Step 4

  Future<void> onBrowseDocuments() async {
    final document = await _documentPicker.pick();
    if (document == null) return;
    _documents.add(document);
    update([AppUpdateIds.onbDocuments]);
  }

  void removeDocument(String id) {
    _documents.removeWhere((document) => document.id == id);
    update([AppUpdateIds.onbDocuments]);
  }

  Future<void> onSubmit() async {
    if (_isSubmitting) return;
    if (_documents.isEmpty) {
      AppSnackbar.show(
        AppStrings.uploadAtLeastOneDocument,
        type: AppSnackbarType.error,
      );
      return;
    }

    _isSubmitting = true;
    update([AppUpdateIds.onbSubmit]);
    try {
      await _repository.submit(
        MechanicOnboardingDraft(
          trade: _trade ?? '',
          yearsRange: _years ?? '',
          city: _city ?? '',
          specialties: {..._specialties},
          brands: {..._brands},
          certifications: {..._certifications},
          skills: {..._skills},
          standardPrice: _parsePrice(standardPriceController.text) ?? 0,
          urgentPrice: _parsePrice(urgentPriceController.text) ?? 0,
          livePrice: _parsePrice(livePriceController.text) ?? 0,
          documents: List.of(_documents),
        ),
      );
    } catch (_) {
      AppSnackbar.show(AppStrings.genericError, type: AppSnackbarType.error);
      return;
    } finally {
      _isSubmitting = false;
      update([AppUpdateIds.onbSubmit]);
    }

    await Get.toNamed<void>(AppRoutes.mechanicSubmitted);
  }

  // Confirmation

  /// The mechanic area is not designed yet; this lands on its placeholder.
  void onGoHome() => Get.offAllNamed<void>(AppRoutes.mechanicHome);

  void onBack() => Get.back<void>();
}
