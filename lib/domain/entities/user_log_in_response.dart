class UserLogInResponse {
  final String id;
  final String? email;
  final String? name;
  final String? photoUrl;

  UserLogInResponse({
    required this.id,
    required this.email,
    required this.name,
    required this.photoUrl,
  });
}
