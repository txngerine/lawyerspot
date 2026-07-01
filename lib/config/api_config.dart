class ApiConfig {
  static const String baseUrl = 'https://lawyerspot.in/api';

  // Public
  static const String health = '/health';
  static const String cms = '/cms';
  static String qaAnswers(String slug) => '/qa/$slug/answers';
  static String sections(String type) => '/sections?type=$type';
  static String section(String slug) => '/sections/$slug';

  // Auth
  static const String lawyerSignup = '/auth/lawyer-signup';
  static const String clientSignup = '/auth/signup';
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String authMe = '/auth/me';

  // Lawyer Profile
  static const String lawyerProfile = '/lawyer/profile';
  static const String changePassword = '/lawyer/change-password';
  static const String subscription = '/lawyer/subscription';
  static const String renewSubscription = '/lawyer/subscription/renew';

  // Lawyer Articles
  static const String lawyerArticles = '/lawyer/articles';
  static String lawyerArticle(String slug) => '/lawyer/articles/$slug';

  // Lawyer Q&A
  static const String lawyerQaQuestions = '/lawyer/qa/questions';
  static const String lawyerQaAnswers = '/lawyer/qa/answers';
  static String lawyerQaQuestion(String id) => '/lawyer/qa/questions/$id';
  static String lawyerQaAnswer(String id) => '/lawyer/qa/questions/$id/answers';
  static String deleteAnswer(String id) => '/lawyer/qa/answers/$id';

  // Lawyer Conversations
  static const String conversations = '/lawyer/conversations';
  static String conversationMessages(String id) =>
      '/lawyer/conversations/$id/messages';
  static String conversationRead(String id) => '/lawyer/conversations/$id/read';

  // Statistics
  static const String statisticsOverview = '/statistics/overview';
}
