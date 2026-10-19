import 'package:pocketwrench/features/mechanic/onboarding/data/models/uploaded_document.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/repositories/document_picker.dart';

/// Pretends to pick a file by returning a sample certificate. Replace with a
/// real file picker once a package is approved.
class MockDocumentPicker implements DocumentPicker {
  int _count = 0;

  @override
  Future<UploadedDocument?> pick() async {
    final number = _count++;
    return UploadedDocument(
      id: 'document-$number',
      name: number == 0
          ? 'ASE_Certification_2026.pdf'
          : 'Credential_${number + 1}.pdf',
      sizeLabel: '3.2 MB',
      kindLabel: 'PDF Document',
    );
  }
}
