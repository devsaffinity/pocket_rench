/// The mechanic's professional details, as customers see them.
class ProfessionalProfile {
  const ProfessionalProfile({
    required this.role,
    required this.city,
    required this.workshop,
    required this.yearsExperience,
    required this.bio,
    required this.brands,
    required this.trade,
    required this.primarySpecialty,
    required this.secondarySpecialty,
    required this.skills,
  });

  /// For example "Automotive Mechanic".
  final String role;
  final String city;
  final String workshop;
  final int yearsExperience;
  final String bio;
  final List<String> brands;
  final String trade;
  final String primarySpecialty;
  final String secondarySpecialty;
  final List<String> skills;
}
