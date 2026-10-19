import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic.dart';

/// The signed-in person shown in the home header.
class HomeUser {
  const HomeUser({required this.name, required this.avatar});

  final String name;

  /// Asset path or network URL.
  final String avatar;
}

class HomeData {
  const HomeData({required this.mechanics});

  final List<Mechanic> mechanics;
}
