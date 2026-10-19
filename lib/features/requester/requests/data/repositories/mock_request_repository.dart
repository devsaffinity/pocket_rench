import 'package:pocketwrench/features/requester/requests/data/models/request_draft.dart';
import 'package:pocketwrench/features/requester/requests/data/repositories/request_repository.dart';
import 'package:pocketwrench/features/shared/requests/data/models/help_request.dart';

/// In-memory sample requests matching the design.
class MockRequestRepository implements RequestRepository {
  static const Duration _latency = Duration(milliseconds: 500);

  final List<HelpRequest> _requests = [
    const HelpRequest(
      id: 'request-1',
      title: 'Engine Stalls After Warming Up',
      category: 'Engine',
      make: 'Ford',
      model: 'F-150',
      year: 2019,
      engine: 'Ecoboost V6',
      urgency: RequestUrgency.urgent,
      description:
          'My F-150 starts up fine in the morning, but once it gets up to '
          'operating temperature, the RPMs dip and it completely stalls when '
          'stopping at lights. No check engine light yet.',
      postedLabel: '2m ago',
    ),
    const HelpRequest(
      id: 'request-2',
      title: 'A/C Blows Hot Air',
      category: 'A/C',
      make: 'Jeep',
      model: 'Wrangler',
      year: 2015,
      engine: '3.6L Pentastar V6',
      urgency: RequestUrgency.normal,
      description: 'The air conditioning only blows warm air, even on max.',
      status: RequestStatus.resolved,
      postedLabel: '2 days ago',
    ),
    const HelpRequest(
      id: 'request-3',
      title: 'Brakes Squeal When Stopping',
      category: 'Brakes',
      make: 'Toyota',
      model: 'Camry',
      year: 2017,
      engine: '2.5L I4',
      urgency: RequestUrgency.normal,
      description: 'A loud squeal when braking at low speed.',
      postedLabel: '5 days ago',
    ),
  ];

  int _nextId = 100;

  @override
  Future<List<HelpRequest>> loadRequests() async {
    await Future<void>.delayed(_latency);
    return List.unmodifiable(_requests);
  }

  @override
  Future<HelpRequest> submit(RequestDraft draft) async {
    await Future<void>.delayed(_latency);
    final request = draft.toRequest('request-${_nextId++}');
    _requests.insert(0, request);
    return request;
  }
}
