class UserModel {
  final String id;
  final String name;
  final String email;
  final String? barNumber;
  final String? barState;
  final int? yearsExperience;
  final List<String> practiceAreas;
  final List<String> cities;
  final int? consultationFee;
  final String? bio;
  final String? photoUrl;
  final String? title;
  final String? firm;
  final double? rating;
  final int? reviewCount;
  final bool isVerified;
  final bool isAvailable;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.barNumber,
    this.barState,
    this.yearsExperience,
    this.practiceAreas = const [],
    this.cities = const [],
    this.consultationFee,
    this.bio,
    this.photoUrl,
    this.title,
    this.firm,
    this.rating,
    this.reviewCount,
    this.isVerified = false,
    this.isAvailable = true,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        barNumber: json['bar_number'] as String?,
        barState: json['bar_state'] as String?,
        yearsExperience: json['years_experience'] as int?,
        practiceAreas: (json['practice_areas'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        cities: (json['cities'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        consultationFee: json['consultation_fee'] as int?,
        bio: json['bio'] as String?,
        photoUrl: json['photo_url'] as String?,
        title: json['title'] as String?,
        firm: json['firm'] as String?,
        rating: (json['rating'] as num?)?.toDouble(),
        reviewCount: json['review_count'] as int?,
        isVerified: json['is_verified'] as bool? ?? false,
        isAvailable: json['is_available'] as bool? ?? true,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'bar_number': barNumber,
        'bar_state': barState,
        'years_experience': yearsExperience,
        'practice_areas': practiceAreas,
        'cities': cities,
        'consultation_fee': consultationFee,
        'bio': bio,
        'photo_url': photoUrl,
        'title': title,
        'firm': firm,
        'rating': rating,
        'review_count': reviewCount,
        'is_verified': isVerified,
        'is_available': isAvailable,
      };
}
