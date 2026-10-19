/// The signed-in person's account details.
class Account {
  const Account({
    required this.name,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.city,
    required this.avatarUrl,
  });

  final String name;
  final String email;
  final String phone;
  final DateTime birthDate;
  final String city;

  /// Network URL of the profile photo.
  final String avatarUrl;

  /// First letters of the first two words of [name], upper-cased.
  String get initials {
    final words = name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
    return words.take(2).map((w) => w[0].toUpperCase()).join();
  }

  Account copyWith({
    String? name,
    String? email,
    String? phone,
    DateTime? birthDate,
    String? city,
  }) {
    return Account(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      city: city ?? this.city,
      avatarUrl: avatarUrl,
    );
  }
}
