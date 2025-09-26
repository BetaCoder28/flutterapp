class UserEntity {
  final int id;
  final String name;
  final String lastname;
  final String email;
  final String phone;
  final String? image;
  final String notificationToken;

  UserEntity({
    required this.id,
    required this.name,
    required this.lastname,
    required this.email,
    required this.phone,
    this.image,
    required this.notificationToken,
  });
}