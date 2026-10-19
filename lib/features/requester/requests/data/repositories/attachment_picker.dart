import 'package:pocketwrench/features/shared/requests/data/models/request_attachment.dart';

enum AttachmentSource { camera, photos, video, document }

/// Gets a file from the camera, gallery or file system. Swap in a real
/// implementation once an image/file picker package is approved.
abstract class AttachmentPicker {
  /// Returns null when the person cancels. The attachment starts at progress
  /// 0; the caller reports upload progress.
  Future<RequestAttachment?> pick(AttachmentSource source);
}
