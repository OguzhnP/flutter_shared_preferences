// ignore_for_file: constant_identifier_names

enum Gender { ERKEK, KADIN }

enum FavoriteColors { SARI, KIRMIZI, MAVI, SIYAH, MOR }

class UserInfo {
  final String name;
  final Gender gender;
  final List<String> favoriteColors;
  final bool isStudent;

  UserInfo(this.name, this.gender, this.favoriteColors, this.isStudent);
}
