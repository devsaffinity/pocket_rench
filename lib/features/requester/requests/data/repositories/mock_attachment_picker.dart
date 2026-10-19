import 'package:pocketwrench/features/requester/requests/data/repositories/attachment_picker.dart';
import 'package:pocketwrench/features/shared/requests/data/models/request_attachment.dart';

/// Pretends to pick a file by returning a sample one.
class MockAttachmentPicker implements AttachmentPicker {
  int _count = 0;

  @override
  Future<RequestAttachment?> pick(AttachmentSource source) async {
    final id = 'attachment-${_count++}';
    return switch (source) {
      AttachmentSource.camera => RequestAttachment(
        id: id,
        name: 'Photo_$_count.jpg',
        kind: AttachmentKind.image,
        sizeLabel: '2.1 MB',
        previewUrl: 'https://picsum.photos/seed/camera$_count/300/300',
        progress: 0,
      ),
      AttachmentSource.photos => RequestAttachment(
        id: id,
        name: 'Engine_bay_leak.jpg',
        kind: AttachmentKind.image,
        sizeLabel: '1.2 MB',
        previewUrl: 'https://picsum.photos/seed/engine-bay-leak/300/300',
        progress: 0,
      ),
      AttachmentSource.video => RequestAttachment(
        id: id,
        name: 'Idle_recording.mp4',
        kind: AttachmentKind.video,
        sizeLabel: '8.4 MB',
        previewUrl: 'https://picsum.photos/seed/idle-recording/300/300',
        progress: 0,
      ),
      AttachmentSource.document => RequestAttachment(
        id: id,
        name: 'Diagnostic_scan_report.pdf',
        kind: AttachmentKind.document,
        sizeLabel: '640 KB',
        progress: 0,
      ),
    };
  }
}
