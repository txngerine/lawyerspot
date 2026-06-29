class LoginRequest {
  final String email;
  final String password;
  final String? role;

  LoginRequest({
    required this.email,
    required this.password,
    this.role,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        if (role != null) 'role': role,
      };
}

class LawyerSignupRequest {
  final String name;
  final String email;
  final String password;
  final String? phone;
  final String practice;
  final String? barId;
  final String? citySlug;

  LawyerSignupRequest({
    required this.name,
    required this.email,
    required this.password,
    this.phone,
    required this.practice,
    this.barId,
    this.citySlug,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        if (phone != null) 'phone': phone,
        'practice': practice,
        if (barId != null) 'bar_id': barId,
        if (citySlug != null) 'city_slug': citySlug,
      };
}

class ClientSignupRequest {
  final String name;
  final String email;
  final String password;

  ClientSignupRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
      };
}

class AuthResponse {
  final bool success;
  final String role;
  final String userId;
  final String? lawyerId;
  final String? name;

  AuthResponse({
    required this.success,
    required this.role,
    required this.userId,
    this.lawyerId,
    this.name,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        success: json['success'] as bool? ?? true,
        role: json['role'] as String? ?? '',
        userId: json['userId'] as String? ?? '',
        lawyerId: json['lawyerId'] as String?,
        name: json['name'] as String?,
      );
}

class SessionUser {
  final String id;
  final String email;
  final String name;
  final String role;
  final String? lawyerId;

  SessionUser({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.lawyerId,
  });

  factory SessionUser.fromJson(Map<String, dynamic> json) => SessionUser(
        id: json['id'] as String? ?? '',
        email: json['email'] as String? ?? '',
        name: json['name'] as String? ?? '',
        role: json['role'] as String? ?? 'client',
        lawyerId: json['lawyerId'] as String?,
      );
}

class ChangePasswordRequest {
  final String currentPassword;
  final String newPassword;

  ChangePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      };
}
