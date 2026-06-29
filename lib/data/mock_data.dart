// ---------------------------------------------------------------------------
// MOCK DATA — Replace this file with real API calls when the backend is ready.
// Each section is clearly labeled so you can find & delete what you no longer
// need.  Controllers and screens import from here instead of hardcoding inline.
// ---------------------------------------------------------------------------
// DELETE THIS FILE once every import below has been replaced by a real API
// service call (see lib/services/).
// ---------------------------------------------------------------------------

import '../models/dashboard_model.dart';
import '../models/consultation_model.dart';
import '../models/qa_model.dart';
import '../models/notification_model.dart';
import '../models/statistics_model.dart';
import '../models/user_model.dart';

// ============================================================================
// 1.  STATIC ENUM-LIKE LISTS (may later come from API enums / config)
// ============================================================================

List<String> mockPracticeAreas() => [
      'Corporate',
      'Criminal',
      'Divorce',
      'Family',
      'GST & Tax',
      'Immigration',
      'Property',
      'Startup',
      'Cyber Crime',
    ];

List<String> mockFilterLabels() => [
      'All Areas',
      'Property Law',
      'Family Law',
      'Corporate',
      'Criminal Defense',
    ];

List<String> mockBarStates() => [
      'New York',
      'California',
      'Texas',
      'Florida',
      'Illinois',
    ];

// ============================================================================
// 2.  SIGN-UP DEFAULTS (pre-populated form values)
// ============================================================================

int mockDefaultYearsExperience() => 5;
Set<String> mockDefaultPracticeAreas() => {'Corporate', 'Property'};
List<String> mockDefaultCities() => ['New York, NY', 'Brooklyn, NY'];
String mockDefaultFee() => '250';

// ============================================================================
// 3.  USER / PROFILE
// ============================================================================

UserModel mockUser() => UserModel(
      id: '1',
      name: 'Eleanor Vance',
      email: 'eleanor@vancecorp.com',
      barNumber: 'BAR/1234/56',
      barState: 'New York',
      yearsExperience: 15,
      practiceAreas: [
        'Corporate Law',
        'Intellectual Property',
        'Contract Negotiation',
      ],
      cities: ['New York City, NY'],
      consultationFee: 350,
      bio:
          'With over 15 years of experience in corporate litigation, I specialize in '
          'complex commercial disputes, intellectual property defense, and high-stakes negotiations.',
      title: 'Senior Partner',
      firm: 'Vance & Associates',
      rating: 4.9,
      reviewCount: 142,
      isVerified: true,
      isAvailable: true,
    );

String mockGreetingFallback() => 'Good morning, Adv. Rajesh';

// ============================================================================
// 4.  DASHBOARD
// ============================================================================

DashboardSummary mockDashboardSummary() => DashboardSummary(
      consultationsThisMonth: 42,
      qaAnswersAllTime: 128,
      profileQuality: 0.85,
      greeting: 'Good morning, Adv. Rajesh',
      actionRequiredTitle: 'Action Required',
      actionRequiredBody:
          'Your recent bar council ID upload is pending verification. '
          'Expedite the process by reviewing the document clarity.',
    );

String mockProfileQualityCaption() =>
    'Add case histories to reach 100%.';

// ============================================================================
// 5.  TODAY'S UPCOMING CONSULTATIONS (dashboard list)
// ============================================================================

List<ConsultationModel> mockUpcomingConsultations() => [
      ConsultationModel(
        id: 'c1',
        clientName: 'Sanjay Kumar',
        clientInitials: 'SK',
        subject: 'Consultation',
        dateLabel: 'Today',
        timeLabel: '10:30 AM (In 5 mins)',
        actionLabel: 'Join Call',
        highlighted: true,
        status: 'upcoming',
      ),
      ConsultationModel(
        id: 'c2',
        clientName: 'Anita Menon',
        clientInitials: 'AM',
        subject: 'Consultation',
        dateLabel: 'Today',
        timeLabel: '02:00 PM',
        actionLabel: 'Details',
        highlighted: false,
        status: 'upcoming',
      ),
    ];

// ============================================================================
// 6.  CONSULTATIONS LIST (full upcoming / past lists)
// ============================================================================

List<ConsultationModel> mockFullUpcomingConsultations() => [
      ConsultationModel(
        id: 'c3',
        clientName: 'Eleanor Vance',
        clientInitials: 'EV',
        subject: 'Corporate Restructuring',
        subjectIcon: 'business_center',
        dateLabel: 'Today',
        timeLabel: '10:00 AM',
        actionLabel: 'Join Call',
        highlighted: true,
        status: 'upcoming',
      ),
      ConsultationModel(
        id: 'c4',
        clientName: 'James Morrison',
        clientInitials: 'JM',
        subject: 'Intellectual Property Dispute',
        subjectIcon: 'gavel',
        dateLabel: 'Tomorrow, Oct 24',
        timeLabel: '2:30 PM',
        actionLabel: 'Starts in 28h',
        highlighted: false,
        status: 'upcoming',
      ),
      ConsultationModel(
        id: 'c5',
        clientName: 'Arthur Pendelton',
        clientInitials: 'AP',
        subject: 'Real Estate Trust',
        subjectIcon: 'real_estate_agent',
        dateLabel: 'Thursday, Oct 26',
        timeLabel: '11:15 AM',
        actionLabel: 'Scheduled',
        highlighted: false,
        status: 'upcoming',
      ),
    ];

// ============================================================================
// 7.  CONSULTATION DETAIL (single consultation full data)
// ============================================================================

ConsultationModel mockConsultationDetail() => ConsultationModel(
      id: 'c3',
      clientName: 'Eleanor Vance',
      clientInitials: 'EV',
      subject: 'Corporate Restructuring Inquiry',
      dateLabel: 'Thursday, October 26',
      timeLabel: '10:00 AM - 11:00 AM EST',
      actionLabel: 'Join Call',
      highlighted: true,
      email: 'e.vance@vancecorp.com',
      phone: '+1 (555) 019-8273',
      reason:
          'Client is seeking preliminary advice regarding a potential merger with '
          'a competitor. They need guidance on anti-trust compliance and an overview '
          'of the required regulatory filings before proceeding with formal negotiations.',
      status: 'upcoming',
      documents: [
        DocumentModel(
          id: 'd1',
          name: 'Vance_Merger_Brief.pdf',
          size: '2.4 MB',
          addedDate: 'Oct 24',
        ),
      ],
    );

// ============================================================================
// 8.  Q&A — BROWSE QUESTIONS
// ============================================================================

List<QuestionModel> mockQuestions() => [
      QuestionModel(
        id: 'q1',
        area: 'Property Law',
        answers: 3,
        title:
            'Landlord refusing to return security deposit after 30 days despite no damages. '
            'What are my options?',
        preview:
            'I moved out of my apartment in California over a month ago. The walkthrough was '
            "clean, no issues noted. Now the landlord is ghosting my calls and hasn't returned the "
            '\$2000 deposit. Can I sue for triple damages?',
        author: 'Anonymous User',
        timeAgo: '2h ago',
      ),
      QuestionModel(
        id: 'q2',
        area: 'Family Law',
        answers: 0,
        title:
            'Modifying child custody agreement due to relocation out of state for work.',
        preview:
            'I have been offered a significant promotion that requires moving from NY to TX. '
            'I currently share 50/50 custody. How difficult is it to modify the agreement to allow '
            'me to take the children with me?',
        author: 'Michael T.',
        timeAgo: '5h ago',
      ),
      QuestionModel(
        id: 'q3',
        area: 'Corporate',
        answers: 1,
        title:
            'Structuring equity vesting for co-founders in an LLC vs C-Corp.',
        preview:
            'We are three co-founders starting a tech company. We want to implement a 4-year '
            'vesting schedule with a 1-year cliff. Are there significant tax or structural differences '
            'if we form an LLC instead of a Delaware C-Corp?',
        author: 'StartupFounder',
        timeAgo: '1d ago',
      ),
    ];

// ============================================================================
// 9.  Q&A — QUESTION DETAIL (answers)
// ============================================================================

List<AnswerModel> mockAnswers() => [
      AnswerModel(
        id: 'a1',
        lawyerName: 'Sarah Jenkins, Esq.',
        lawyerInitials: 'SJ',
        lawyerTitle: 'Real Estate Attorney',
        lawyerLocation: 'CA',
        body:
            'Under California Civil Code Section 1950.5, a landlord has 21 days after '
            'you move out to either return your deposit in full or provide a good faith '
            'estimate of deductions along with the remaining balance. If they fail to do '
            'so, they forfeit the right to keep any portion of the deposit for damages, '
            'cleaning, or unpaid rent. You can indeed sue in small claims court for the '
            'return of the deposit plus statutory damages of up to twice the amount of '
            'the deposit if you can prove bad faith retention.',
        helpfulCount: 12,
        createdAt: '2h ago',
      ),
    ];

String mockQuestionDetailArea() => 'Property Law';
String mockQuestionDetailTime() => '2h ago';
String mockQuestionDetailAuthor() => 'Anonymous User';
String mockAnswersSectionLabel(int count) =>
    '$count Answers from Verified Lawyers';

// ============================================================================
// 10.  Q&A — MY ANSWERS (history)
// ============================================================================

List<MyAnswerModel> mockMyAnswers() => [
      MyAnswerModel(
        id: 'ma1',
        area: 'Corporate Law',
        date: 'Oct 24, 2023',
        helpful: 12,
        question:
            'What are the immediate tax implications of dissolving an LLC in California?',
        preview:
            'When dissolving an LLC in California, you must first file a Certificate of '
            'Cancellation (Form LLC-4/7) with the Secretary of State. The primary tax implication '
            'involves the final franchise tax payment...',
      ),
      MyAnswerModel(
        id: 'ma2',
        area: 'Intellectual Property',
        date: 'Oct 18, 2023',
        helpful: 5,
        question:
            'Can I trademark a phrase that is commonly used in my specific industry but not registered?',
        preview:
            'Trademarking a commonly used phrase within your specific industry can be highly '
            'challenging. The USPTO generally requires that a trademark be "distinctive"...',
      ),
      MyAnswerModel(
        id: 'ma3',
        area: 'Real Estate',
        date: 'Oct 12, 2023',
        helpful: 1,
        question:
            'How long does a landlord have to return a security deposit in New York?',
        preview:
            'Under New York state law, specifically the Housing Stability and Tenant '
            'Protection Act of 2019, a landlord must return the security deposit within 14 days...',
      ),
    ];

// ============================================================================
// 11.  NOTIFICATIONS
// ============================================================================

List<NotificationModel> mockNotifications() => [
      NotificationModel(
        id: 'n1',
        icon: 'event',
        title: 'Consultation Reminder',
        subtitle:
            'Upcoming video call with Sarah Jenkins regarding Family Law.',
        trailing: '10:00 AM',
        unread: true,
        action: 'Join Call',
      ),
      NotificationModel(
        id: 'n2',
        icon: 'quiz',
        title: 'New Q&A Inquiry',
        subtitle:
            'A verified user asked a new question in Corporate Structuring.',
        trailing: '2h ago',
        unread: true,
      ),
      NotificationModel(
        id: 'n3',
        icon: 'verified',
        title: 'Verification Approved',
        subtitle:
            'Your Bar Association credentials have been successfully verified.',
        trailing: 'Yesterday',
        unread: false,
      ),
      NotificationModel(
        id: 'n4',
        icon: 'star',
        title: 'New 5-Star Review',
        subtitle:
            '"Excellent counsel and very responsive..." - Client A.',
        trailing: 'Mon',
        unread: false,
      ),
    ];

// ============================================================================
// 12.  STATISTICS
// ============================================================================

StatisticsModel mockStatistics() => StatisticsModel(
      rating: 4.9,
      totalClients: 87,
      responseRate: 98,
      averageResponseHours: 2.4,
      profileViews: 120,
      reviewCount: 142,
      weeklyConsultations: [0.40, 0.65, 0.85, 0.50],
    );

List<double> mockChartPoints() => [0.30, 0.50, 0.35, 0.70, 0.55, 0.80];

String mockReviewCountText(int count) => 'Based on $count reviews';

// ============================================================================
// 13.  DEFAULT AVATAR INITIALS
// ============================================================================

String mockDefaultAvatarInitials() => 'AR';

// ============================================================================
// 14.  PROFILE EDITOR DEFAULTS
// ============================================================================

String mockEditorYears() => '15';
String mockEditorFee() => '350';
String mockEditorCity() => 'New York City, NY';
String mockEditorBio() =>
    'With over 15 years of experience in corporate litigation, I specialize in '
    'complex commercial disputes, intellectual property defense, and high-stakes negotiations.';
Set<String> mockEditorPracticeAreas() => {
      'Corporate Law',
      'Intellectual Property',
      'Contract Negotiation',
    };
