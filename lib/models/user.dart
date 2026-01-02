class AppUser {
  final String id;
  final String fullName;
  final String email;

  AppUser({required this.id, required this.fullName, required this.email});

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'].toString(),
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
