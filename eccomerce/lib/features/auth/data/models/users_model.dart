class UserModel {
  final int id;
  final String name;
  final String lastname;
  final String email;
  final String phone;
  final String? image;
  final String? password; // Solo para registro
  final String? accessToken; // Token JWT
  final String? notificationToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.lastname,
    required this.email,
    required this.phone,
    this.image,
    this.password,
    this.accessToken,
    this.notificationToken,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'],
      accessToken: json['access_token'] ?? json['accessToken'],
      notificationToken: json['notification_token'] ?? json['notificationToken'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'image': image,
      if (password != null) 'password': password,
      'access_token': accessToken,
      'notification_token': notificationToken,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toRegisterJson() {
    return {
      'name': name,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'password': password,
      'notification_token': notificationToken,
    };
  }
}