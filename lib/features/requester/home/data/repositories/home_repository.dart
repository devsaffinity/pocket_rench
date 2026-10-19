import 'package:pocketwrench/features/requester/home/data/models/home_data.dart';

/// Everything the home tab shows.
abstract class HomeRepository {
  Future<HomeData> loadHome();
}
