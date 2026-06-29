class ApiConfig {
  static const String baseUrl = 'https://api.lawyerspot.com/v1';

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';

  // Dashboard
  static const String dashboardSummary = '/dashboard/summary';
  static const String dashboardActionRequired = '/dashboard/action-required';

  // Consultations
  static const String consultations = '/consultations';
  static String consultation(String id) => '/consultations/$id';
  static String consultationNotes(String id) => '/consultations/$id/notes';
  static String consultationDocuments(String id) => '/consultations/$id/documents';

  // Q&A
  static const String questions = '/qa/questions';
  static String question(String id) => '/qa/questions/$id';
  static String questionAnswers(String id) => '/qa/questions/$id/answers';
  static const String myAnswers = '/qa/my-answers';

  // Profile
  static const String profile = '/profile';
  static const String profileVerificationStatus = '/profile/verification-status';
  static const String profilePhoto = '/profile/photo';

  // Notifications
  static const String notifications = '/notifications';
  static String notificationRead(String id) => '/notifications/$id/read';

  // Statistics
  static const String statisticsOverview = '/statistics/overview';

  // Settings
  static const String settingsNotifications = '/settings/notifications';
  static const String settingsPayment = '/settings/payment';
}
