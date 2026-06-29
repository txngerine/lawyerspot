class Lawyer {
  final String id;
  final String slug;
  final String name;
  final String image;
  final double rating;
  final int reviews;
  final int experience;
  final int fee;
  final String currency;
  final String location;
  final String address;
  final String practice;
  final String citySlug;
  final List<String> specialization;
  final bool online;
  final bool verified;
  final String phone;
  final List<String> languages;
  final String firm;
  final String bio;
  final List<Education> education;
  final List<Timeline> timeline;
  final List<PracticeGroup> practiceGroups;
  final List<String> courts;
  final List<Award> awards;
  final List<ClientReview> clientReviews;
  final List<ProfileFaq> profileFaq;
  final String email;
  final bool emailVerified;
  final bool phoneVerified;
  final String subscriptionPlanId;
  final String? subscriptionExpiresAt;
  final bool topRated;

  Lawyer({
    this.id = '',
    this.slug = '',
    this.name = '',
    this.image = '',
    this.rating = 0.0,
    this.reviews = 0,
    this.experience = 0,
    this.fee = 0,
    this.currency = 'INR',
    this.location = '',
    this.address = '',
    this.practice = '',
    this.citySlug = '',
    this.specialization = const [],
    this.online = false,
    this.verified = false,
    this.phone = '',
    this.languages = const [],
    this.firm = '',
    this.bio = '',
    this.education = const [],
    this.timeline = const [],
    this.practiceGroups = const [],
    this.courts = const [],
    this.awards = const [],
    this.clientReviews = const [],
    this.profileFaq = const [],
    this.email = '',
    this.emailVerified = false,
    this.phoneVerified = false,
    this.subscriptionPlanId = '',
    this.subscriptionExpiresAt,
    this.topRated = false,
  });

  factory Lawyer.fromJson(Map<String, dynamic> json) => Lawyer(
        id: json['id'] as String? ?? '',
        slug: json['slug'] as String? ?? '',
        name: json['name'] as String? ?? '',
        image: json['image'] as String? ?? '',
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        reviews: json['reviews'] as int? ?? 0,
        experience: json['experience'] as int? ?? 0,
        fee: json['fee'] as int? ?? 0,
        currency: json['currency'] as String? ?? 'INR',
        location: json['location'] as String? ?? '',
        address: json['address'] as String? ?? '',
        practice: json['practice'] as String? ?? '',
        citySlug: json['citySlug'] as String? ?? '',
        specialization: (json['specialization'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        online: json['online'] as bool? ?? false,
        verified: json['verified'] as bool? ?? false,
        phone: json['phone'] as String? ?? '',
        languages: (json['languages'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        firm: json['firm'] as String? ?? '',
        bio: json['bio'] as String? ?? '',
        education: (json['education'] as List<dynamic>?)
                ?.map((e) => Education.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        timeline: (json['timeline'] as List<dynamic>?)
                ?.map((e) => Timeline.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        practiceGroups: (json['practiceGroups'] as List<dynamic>?)
                ?.map(
                    (e) => PracticeGroup.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        courts: (json['courts'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        awards: (json['awards'] as List<dynamic>?)
                ?.map((e) => Award.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        clientReviews: (json['clientReviews'] as List<dynamic>?)
                ?.map(
                    (e) => ClientReview.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        profileFaq: (json['profileFaq'] as List<dynamic>?)
                ?.map((e) => ProfileFaq.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        email: json['email'] as String? ?? '',
        emailVerified: json['emailVerified'] as bool? ?? false,
        phoneVerified: json['phoneVerified'] as bool? ?? false,
        subscriptionPlanId: json['subscriptionPlanId'] as String? ?? '',
        subscriptionExpiresAt: json['subscriptionExpiresAt'] as String?,
        topRated: json['topRated'] as bool? ?? false,
      );
}

class Education {
  final String degree;
  final String institution;
  final String year;

  Education({this.degree = '', this.institution = '', this.year = ''});

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        degree: json['degree'] as String? ?? '',
        institution: json['institution'] as String? ?? '',
        year: json['year'] as String? ?? '',
      );
}

class Timeline {
  final String year;
  final String title;
  final String org;

  Timeline({this.year = '', this.title = '', this.org = ''});

  factory Timeline.fromJson(Map<String, dynamic> json) => Timeline(
        year: json['year'] as String? ?? '',
        title: json['title'] as String? ?? '',
        org: json['org'] as String? ?? '',
      );
}

class PracticeGroup {
  final String title;
  final List<String> areas;

  PracticeGroup({this.title = '', this.areas = const []});

  factory PracticeGroup.fromJson(Map<String, dynamic> json) => PracticeGroup(
        title: json['title'] as String? ?? '',
        areas: (json['areas'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
      );
}

class Award {
  final String title;
  final String year;

  Award({this.title = '', this.year = ''});

  factory Award.fromJson(Map<String, dynamic> json) => Award(
        title: json['title'] as String? ?? '',
        year: json['year'] as String? ?? '',
      );
}

class ClientReview {
  final String author;
  final double rating;
  final String text;
  final String date;
  final bool verified;
  final String avatar;

  ClientReview({
    this.author = '',
    this.rating = 0.0,
    this.text = '',
    this.date = '',
    this.verified = false,
    this.avatar = '',
  });

  factory ClientReview.fromJson(Map<String, dynamic> json) => ClientReview(
        author: json['author'] as String? ?? '',
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        text: json['text'] as String? ?? '',
        date: json['date'] as String? ?? '',
        verified: json['verified'] as bool? ?? false,
        avatar: json['avatar'] as String? ?? '',
      );
}

class ProfileFaq {
  final String id;
  final String question;
  final String answer;

  ProfileFaq({this.id = '', this.question = '', this.answer = ''});

  factory ProfileFaq.fromJson(Map<String, dynamic> json) => ProfileFaq(
        id: json['id'] as String? ?? '',
        question: json['question'] as String? ?? '',
        answer: json['answer'] as String? ?? '',
      );
}
