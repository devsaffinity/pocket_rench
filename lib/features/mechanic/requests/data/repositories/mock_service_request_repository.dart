import 'package:pocketwrench/features/mechanic/requests/data/models/service_request.dart';
import 'package:pocketwrench/features/mechanic/requests/data/repositories/service_request_repository.dart';
import 'package:pocketwrench/features/shared/requests/data/models/help_request.dart';
import 'package:pocketwrench/features/shared/requests/data/models/request_attachment.dart';

/// Fixed sample requests matching the design. Responses last until restart.
class MockServiceRequestRepository implements ServiceRequestRepository {
  static const Duration _latency = Duration(milliseconds: 400);

  static const String _stallsDescription =
      'My F-150 starts up fine in the morning, but once it gets up to '
      'operating temperature, the RPMs dip and it completely stalls when '
      'stopping at lights. No check engine light yet.';

  final List<ServiceRequest> _requests = [
    // Waiting for an answer.
    const ServiceRequest(
      id: 'engine-stalls',
      request: HelpRequest(
        id: 'engine-stalls',
        title: 'Engine Stalls After Warming Up',
        category: 'Engine',
        make: 'Ford',
        model: 'F-150',
        year: 2019,
        urgency: RequestUrgency.urgent,
        description: _stallsDescription,
        postedLabel: '2m ago',
        attachments: [
          RequestAttachment(
            id: 'engine-bay',
            name: 'Engine_bay.jpg',
            kind: AttachmentKind.image,
            sizeLabel: '1.2 MB',
            previewUrl: 'https://picsum.photos/seed/engine-bay-stalls/300/300',
          ),
          RequestAttachment(
            id: 'idle-video',
            name: 'Idle_recording.mp4',
            kind: AttachmentKind.video,
            sizeLabel: '8.4 MB',
            previewUrl: 'https://picsum.photos/seed/idle-stalls/300/300',
          ),
          RequestAttachment(
            id: 'scan-report',
            name: 'Scan_report.pdf',
            kind: AttachmentKind.document,
            sizeLabel: '640 KB',
          ),
        ],
      ),
      requesterName: 'James Wilson',
      requesterCity: 'Dallas, TX',
      priority: RequestPriority.urgent,
      status: ServiceStatus.pending,
    ),
    const ServiceRequest(
      id: 'engine-overheating',
      request: HelpRequest(
        id: 'engine-overheating',
        title: 'Engine Overheating',
        category: 'Engine',
        make: 'Ford',
        model: 'F-150',
        year: 2018,
        urgency: RequestUrgency.normal,
        description:
            'The temperature gauge climbs past the middle after about ten '
            'minutes in traffic.',
        postedLabel: '3 days ago',
      ),
      requesterName: 'Daniel Brooks',
      requesterCity: 'Houston, TX',
      priority: RequestPriority.normal,
      status: ServiceStatus.pending,
    ),
    const ServiceRequest(
      id: 'battery-warning-light',
      request: HelpRequest(
        id: 'battery-warning-light',
        title: 'Battery Warning Light',
        category: 'Battery',
        make: 'Honda',
        model: 'Accord',
        year: 2020,
        urgency: RequestUrgency.normal,
        description: 'The battery light stays on after the engine starts.',
        postedLabel: '1 week ago',
      ),
      requesterName: 'Emily Carter',
      requesterCity: 'Austin, TX',
      priority: RequestPriority.normal,
      status: ServiceStatus.pending,
    ),
    const ServiceRequest(
      id: 'ac-blows-hot-air',
      request: HelpRequest(
        id: 'ac-blows-hot-air',
        title: 'AC Blows Hot Air',
        category: 'A/C',
        make: 'Jeep',
        model: 'Wrangler',
        year: 2015,
        urgency: RequestUrgency.normal,
        description:
            'The A/C only blows warm air, even on the coldest setting.',
        postedLabel: '2 days ago',
      ),
      requesterName: 'Noah Bennett',
      requesterCity: 'Phoenix, AZ',
      priority: RequestPriority.normal,
      status: ServiceStatus.pending,
    ),
    // Accepted.
    const ServiceRequest(
      id: 'transmission-fluid-leak',
      request: HelpRequest(
        id: 'transmission-fluid-leak',
        title: 'Transmission Fluid Leak',
        category: 'Transmission',
        make: 'Toyota',
        model: 'Camry',
        year: 2020,
        urgency: RequestUrgency.urgent,
        description: 'Red fluid is dripping under the car after it is parked.',
        postedLabel: '1h ago',
      ),
      requesterName: 'Sarah Lee',
      requesterCity: 'Dallas, TX',
      priority: RequestPriority.important,
      status: ServiceStatus.active,
      lastMessage: "I've checked the levels, and it's low.",
    ),
    const ServiceRequest(
      id: 'check-engine-light',
      request: HelpRequest(
        id: 'check-engine-light',
        title: 'Check Engine Light On',
        category: 'Diagnostics',
        make: 'Honda',
        model: 'Civic',
        year: 2018,
        urgency: RequestUrgency.normal,
        description: 'The check engine light came on this morning.',
        postedLabel: '30m ago',
      ),
      requesterName: 'Robert Smith',
      requesterCity: 'Houston, TX',
      priority: RequestPriority.normal,
      status: ServiceStatus.active,
      lastMessage: 'Can you run a diagnostic scan?',
    ),
    const ServiceRequest(
      id: 'engine-stalls-accepted',
      request: HelpRequest(
        id: 'engine-stalls-accepted',
        title: 'Engine Stalls After Warming Up',
        category: 'Engine',
        make: 'Ford',
        model: 'F-150',
        year: 2019,
        urgency: RequestUrgency.urgent,
        description: _stallsDescription,
        postedLabel: '2m ago',
        attachments: [
          RequestAttachment(
            id: 'engine-bay-2',
            name: 'Engine_bay.jpg',
            kind: AttachmentKind.image,
            sizeLabel: '1.2 MB',
            previewUrl: 'https://picsum.photos/seed/engine-bay-stalls/300/300',
          ),
          RequestAttachment(
            id: 'idle-video-2',
            name: 'Idle_recording.mp4',
            kind: AttachmentKind.video,
            sizeLabel: '8.4 MB',
            previewUrl: 'https://picsum.photos/seed/idle-stalls/300/300',
          ),
          RequestAttachment(
            id: 'scan-report-2',
            name: 'Scan_report.pdf',
            kind: AttachmentKind.document,
            sizeLabel: '640 KB',
          ),
        ],
      ),
      requesterName: 'James Wilson',
      requesterCity: 'Dallas, TX',
      priority: RequestPriority.urgent,
      status: ServiceStatus.active,
      lastMessage: 'The coolant level is normal.',
    ),
    // Finished.
    const ServiceRequest(
      id: 'transmission-fluid-leak-done',
      request: HelpRequest(
        id: 'transmission-fluid-leak-done',
        title: 'Transmission Fluid Leak',
        category: 'Transmission',
        make: 'Toyota',
        model: 'Camry',
        year: 2020,
        urgency: RequestUrgency.normal,
        description: 'Red fluid is dripping under the car after it is parked.',
        postedLabel: '1h ago',
      ),
      requesterName: 'Sarah Lee',
      requesterCity: 'Dallas, TX',
      priority: RequestPriority.important,
      status: ServiceStatus.resolved,
    ),
    const ServiceRequest(
      id: 'check-engine-light-done',
      request: HelpRequest(
        id: 'check-engine-light-done',
        title: 'Check Engine Light On',
        category: 'Diagnostics',
        make: 'Honda',
        model: 'Civic',
        year: 2018,
        urgency: RequestUrgency.normal,
        description: 'The check engine light came on this morning.',
        postedLabel: '30m ago',
      ),
      requesterName: 'Robert Smith',
      requesterCity: 'Houston, TX',
      priority: RequestPriority.normal,
      status: ServiceStatus.resolved,
    ),
  ];

  @override
  Future<List<ServiceRequest>> loadRequests() async {
    await Future<void>.delayed(_latency);
    return List.unmodifiable(_requests);
  }

  @override
  Future<ServiceRequest> loadRequest(String id) async {
    await Future<void>.delayed(_latency);
    return _requests.firstWhere((request) => request.id == id);
  }

  @override
  Future<void> respond(String id, {required bool accept}) async {
    await Future<void>.delayed(_latency);
    final index = _requests.indexWhere((request) => request.id == id);
    if (index < 0) return;
    if (accept) {
      _requests[index] = _requests[index].copyWith(
        status: ServiceStatus.active,
      );
    } else {
      _requests.removeAt(index);
    }
  }
}
