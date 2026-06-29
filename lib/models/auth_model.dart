class LoginRequest {
  final String email;
  final String password;
  final bool rememberMe;

  LoginRequest({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'remember_me': rememberMe,
      };
}

class RegisterRequest {
  final String name;
  final String email;
  final String barNumber;
  final String barState;
  final int yearsExperience;
  final List<String> practiceAreas;
  final List<String> cities;
  final int consultationFee;
  final String bio;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.barNumber,
    required this.barState,
    required this.yearsExperience,
    required this.practiceAreas,
    required this.cities,
    required this.consultationFee,
    required this.bio,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'bar_number': barNumber,
        'bar_state': barState,
        'years_experience': yearsExperience,
        'practice_areas': practiceAreas,
        'cities': cities,
        'consultation_fee': consultationFee,
        'bio': bio,
      };
}

class AuthResponse {
  final String token;
  final UserData user;

  AuthResponse({required this.token, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        token: json['token'] as String,
        user: UserData.fromJson(json['user'] as Map<String, dynamic>),
      );
}

class UserData {
  final String id;
  final String name;
  final String email;

  UserData({required this.id, required this.name, required this.email});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
      );
}
