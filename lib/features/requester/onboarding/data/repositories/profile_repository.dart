/// Requester profile data.
abstract class ProfileRepository {
  /// Cities a requester can pick as their location.
  Future<List<String>> loadCities();

  Future<void> saveProfile({String? photoPath, String? city});
}
