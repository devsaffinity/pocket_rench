import 'package:pocketwrench/features/mechanic/onboarding/data/models/uploaded_document.dart';

/// Lets the mechanic choose a credential document. Returns null if cancelled.
abstract class DocumentPicker {
  Future<UploadedDocument?> pick();
}
