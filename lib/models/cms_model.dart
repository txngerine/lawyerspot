import 'lawyer_model.dart';
import 'article_model.dart';
import 'qa_model.dart';

class CmsData {
  final SiteConfig siteConfig;
  final SiteContent siteContent;
  final List<SubscriptionPlan> subscriptionPlans;
  final List<StatItem> stats;
  final List<PracticeArea> practiceAreas;
  final List<StateEntry> states;
  final List<City> cities;
  final List<Lawyer> lawyers;
  final List<QaPost> qaPosts;
  final List<Article> articles;
  final List<String> trendingTopics;
  final List<DefaultProfileReview> defaultProfileReviews;
  final String updatedAt;

  CmsData({
    required this.siteConfig,
    required this.siteContent,
    this.subscriptionPlans = const [],
    this.stats = const [],
    this.practiceAreas = const [],
    this.states = const [],
    this.cities = const [],
    this.lawyers = const [],
    this.qaPosts = const [],
    this.articles = const [],
    this.trendingTopics = const [],
    this.defaultProfileReviews = const [],
    this.updatedAt = '',
  });

  factory CmsData.fromJson(Map<String, dynamic> json) => CmsData(
        siteConfig:
            SiteConfig.fromJson(json['siteConfig'] as Map<String, dynamic>? ?? {}),
        siteContent: SiteContent.fromJson(
            json['siteContent'] as Map<String, dynamic>? ?? {}),
        subscriptionPlans: (json['subscriptionPlans'] as List<dynamic>?)
                ?.map((e) =>
                    SubscriptionPlan.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        stats: (json['stats'] as List<dynamic>?)
                ?.map((e) => StatItem.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        practiceAreas: (json['practiceAreas'] as List<dynamic>?)
                ?.map((e) =>
                    PracticeArea.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        states: (json['states'] as List<dynamic>?)
                ?.map((e) => StateEntry.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        cities: (json['cities'] as List<dynamic>?)
                ?.map((e) => City.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        lawyers: (json['lawyers'] as List<dynamic>?)
                ?.map((e) => Lawyer.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        qaPosts: (json['qaPosts'] as List<dynamic>?)
                ?.map((e) => QaPost.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        articles: (json['articles'] as List<dynamic>?)
                ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        trendingTopics: (json['trendingTopics'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        defaultProfileReviews:
            (json['defaultProfileReviews'] as List<dynamic>?)
                    ?.map((e) =>
                        DefaultProfileReview.fromJson(e as Map<String, dynamic>))
                    .toList() ??
                [],
        updatedAt: json['updatedAt'] as String? ?? '',
      );
}

class SiteConfig {
  final String name;
  final String tagline;
  final String url;
  final String description;

  SiteConfig({
    this.name = '',
    this.tagline = '',
    this.url = '',
    this.description = '',
  });

  factory SiteConfig.fromJson(Map<String, dynamic> json) => SiteConfig(
        name: json['name'] as String? ?? '',
        tagline: json['tagline'] as String? ?? '',
        url: json['url'] as String? ?? '',
        description: json['description'] as String? ?? '',
      );
}

class StatItem {
  final String label;
  final String value;

  StatItem({required this.label, required this.value});

  factory StatItem.fromJson(Map<String, dynamic> json) => StatItem(
        label: json['label'] as String? ?? '',
        value: json['value'] as String? ?? '',
      );
}

class PracticeArea {
  final String slug;
  final String name;
  final String icon;
  final int lawyers;

  PracticeArea({
    this.slug = '',
    this.name = '',
    this.icon = '',
    this.lawyers = 0,
  });

  factory PracticeArea.fromJson(Map<String, dynamic> json) => PracticeArea(
        slug: json['slug'] as String? ?? '',
        name: json['name'] as String? ?? '',
        icon: json['icon'] as String? ?? '',
        lawyers: json['lawyers'] as int? ?? 0,
      );
}

class StateEntry {
  final String slug;
  final String name;
  final String code;
  final bool active;

  StateEntry({
    this.slug = '',
    this.name = '',
    this.code = '',
    this.active = false,
  });

  factory StateEntry.fromJson(Map<String, dynamic> json) => StateEntry(
        slug: json['slug'] as String? ?? '',
        name: json['name'] as String? ?? '',
        code: json['code'] as String? ?? '',
        active: json['active'] as bool? ?? false,
      );
}

class City {
  final String slug;
  final String name;
  final String state;

  City({this.slug = '', this.name = '', this.state = ''});

  factory City.fromJson(Map<String, dynamic> json) => City(
        slug: json['slug'] as String? ?? '',
        name: json['name'] as String? ?? '',
        state: json['state'] as String? ?? '',
      );
}

class SubscriptionPlan {
  final String id;
  final String name;
  final int priceMonthly;
  final String currency;
  final String description;
  final List<String> features;
  final bool highlight;
  final int sortOrder;
  final bool active;

  SubscriptionPlan({
    this.id = '',
    this.name = '',
    this.priceMonthly = 0,
    this.currency = 'INR',
    this.description = '',
    this.features = const [],
    this.highlight = false,
    this.sortOrder = 0,
    this.active = false,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlan(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        priceMonthly: json['priceMonthly'] as int? ?? 0,
        currency: json['currency'] as String? ?? 'INR',
        description: json['description'] as String? ?? '',
        features: (json['features'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        highlight: json['highlight'] as bool? ?? false,
        sortOrder: json['sortOrder'] as int? ?? 0,
        active: json['active'] as bool? ?? false,
      );
}

class DefaultProfileReview {
  final String author;
  final double rating;
  final String text;
  final String date;
  final bool verified;
  final String avatar;

  DefaultProfileReview({
    this.author = '',
    this.rating = 0.0,
    this.text = '',
    this.date = '',
    this.verified = false,
    this.avatar = '',
  });

  factory DefaultProfileReview.fromJson(Map<String, dynamic> json) =>
      DefaultProfileReview(
        author: json['author'] as String? ?? '',
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        text: json['text'] as String? ?? '',
        date: json['date'] as String? ?? '',
        verified: json['verified'] as bool? ?? false,
        avatar: json['avatar'] as String? ?? '',
      );
}

class SiteContent {
  final HeroSection hero;
  final List<CourtEntry> courts;
  final List<ActEntry> acts;
  final List<LegalGuide> legalGuides;
  final List<IpcSectionEntry> ipcSections;
  final List<BnsSectionEntry> bnsSections;
  final List<QaCategory> qaCategories;
  final List<PopularSearch> popularSearches;
  final PageContent about;
  final PageContent termsPage;
  final PageContent privacyPage;
  final PageMeta ipcPage;
  final PageMeta bnsPage;
  final PageMeta courtsPage;
  final Footer footer;
  final List<Language> languages;
  final List<NavItem> utilityNav;
  final List<NavItem> mainNav;
  final List<dynamic> customCmsPages;

  SiteContent({
    this.hero = const HeroSection(),
    this.courts = const [],
    this.acts = const [],
    this.legalGuides = const [],
    this.ipcSections = const [],
    this.bnsSections = const [],
    this.qaCategories = const [],
    this.popularSearches = const [],
    this.about = const PageContent(),
    this.termsPage = const PageContent(),
    this.privacyPage = const PageContent(),
    this.ipcPage = const PageMeta(),
    this.bnsPage = const PageMeta(),
    this.courtsPage = const PageMeta(),
    this.footer = const Footer(),
    this.languages = const [],
    this.utilityNav = const [],
    this.mainNav = const [],
    this.customCmsPages = const [],
  });

  factory SiteContent.fromJson(Map<String, dynamic> json) => SiteContent(
        hero: HeroSection.fromJson(json['hero'] as Map<String, dynamic>? ?? {}),
        courts: (json['courts'] as List<dynamic>?)
                ?.map((e) =>
                    CourtEntry.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        acts: (json['acts'] as List<dynamic>?)
                ?.map((e) =>
                    ActEntry.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        legalGuides: (json['legalGuides'] as List<dynamic>?)
                ?.map((e) =>
                    LegalGuide.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        ipcSections: (json['ipcSections'] as List<dynamic>?)
                ?.map((e) =>
                    IpcSectionEntry.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        bnsSections: (json['bnsSections'] as List<dynamic>?)
                ?.map((e) =>
                    BnsSectionEntry.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        qaCategories: (json['qaCategories'] as List<dynamic>?)
                ?.map((e) =>
                    QaCategory.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        popularSearches: (json['popularSearches'] as List<dynamic>?)
                ?.map((e) =>
                    PopularSearch.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        about:
            PageContent.fromJson(json['about'] as Map<String, dynamic>? ?? {}),
        termsPage: PageContent.fromJson(
            json['termsPage'] as Map<String, dynamic>? ?? {}),
        privacyPage: PageContent.fromJson(
            json['privacyPage'] as Map<String, dynamic>? ?? {}),
        ipcPage:
            PageMeta.fromJson(json['ipcPage'] as Map<String, dynamic>? ?? {}),
        bnsPage:
            PageMeta.fromJson(json['bnsPage'] as Map<String, dynamic>? ?? {}),
        courtsPage: PageMeta.fromJson(
            json['courtsPage'] as Map<String, dynamic>? ?? {}),
        footer:
            Footer.fromJson(json['footer'] as Map<String, dynamic>? ?? {}),
        languages: (json['languages'] as List<dynamic>?)
                ?.map((e) =>
                    Language.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        utilityNav: (json['utilityNav'] as List<dynamic>?)
                ?.map(
                    (e) => NavItem.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        mainNav: (json['mainNav'] as List<dynamic>?)
                ?.map(
                    (e) => NavItem.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        customCmsPages: json['customCmsPages'] as List<dynamic>? ?? [],
      );
}

class HeroSection {
  final String title;
  final String subtitle;
  final List<String> badges;

  const HeroSection({
    this.title = '',
    this.subtitle = '',
    this.badges = const [],
  });

  factory HeroSection.fromJson(Map<String, dynamic> json) => HeroSection(
        title: json['title'] as String? ?? '',
        subtitle: json['subtitle'] as String? ?? '',
        badges: (json['badges'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
      );
}

class CourtEntry {
  final String slug;
  final String name;
  final String city;
  final String body;
  final String metaTitle;
  final String metaDescription;

  CourtEntry({
    this.slug = '',
    this.name = '',
    this.city = '',
    this.body = '',
    this.metaTitle = '',
    this.metaDescription = '',
  });

  factory CourtEntry.fromJson(Map<String, dynamic> json) => CourtEntry(
        slug: json['slug'] as String? ?? '',
        name: json['name'] as String? ?? '',
        city: json['city'] as String? ?? '',
        body: json['body'] as String? ?? '',
        metaTitle: json['metaTitle'] as String? ?? '',
        metaDescription: json['metaDescription'] as String? ?? '',
      );
}

class ActEntry {
  final String slug;
  final String title;
  final String act;
  final String body;

  ActEntry({
    this.slug = '',
    this.title = '',
    this.act = '',
    this.body = '',
  });

  factory ActEntry.fromJson(Map<String, dynamic> json) => ActEntry(
        slug: json['slug'] as String? ?? '',
        title: json['title'] as String? ?? '',
        act: json['act'] as String? ?? '',
        body: json['body'] as String? ?? '',
      );
}

class LegalGuide {
  final String slug;
  final String title;
  final String category;

  LegalGuide({
    this.slug = '',
    this.title = '',
    this.category = '',
  });

  factory LegalGuide.fromJson(Map<String, dynamic> json) => LegalGuide(
        slug: json['slug'] as String? ?? '',
        title: json['title'] as String? ?? '',
        category: json['category'] as String? ?? '',
      );
}

class IpcSectionEntry {
  final String slug;
  final String title;
  final String code;
  final String body;

  IpcSectionEntry({
    this.slug = '',
    this.title = '',
    this.code = '',
    this.body = '',
  });

  factory IpcSectionEntry.fromJson(Map<String, dynamic> json) =>
      IpcSectionEntry(
        slug: json['slug'] as String? ?? '',
        title: json['title'] as String? ?? '',
        code: json['code'] as String? ?? '',
        body: json['body'] as String? ?? '',
      );
}

class BnsSectionEntry {
  final String slug;
  final String title;
  final String code;
  final String body;

  BnsSectionEntry({
    this.slug = '',
    this.title = '',
    this.code = '',
    this.body = '',
  });

  factory BnsSectionEntry.fromJson(Map<String, dynamic> json) =>
      BnsSectionEntry(
        slug: json['slug'] as String? ?? '',
        title: json['title'] as String? ?? '',
        code: json['code'] as String? ?? '',
        body: json['body'] as String? ?? '',
      );
}

class QaCategory {
  final String slug;
  final String name;
  final int count;

  QaCategory({
    this.slug = '',
    this.name = '',
    this.count = 0,
  });

  factory QaCategory.fromJson(Map<String, dynamic> json) => QaCategory(
        slug: json['slug'] as String? ?? '',
        name: json['name'] as String? ?? '',
        count: json['count'] as int? ?? 0,
      );
}

class PopularSearch {
  final String label;
  final String href;

  PopularSearch({this.label = '', this.href = ''});

  factory PopularSearch.fromJson(Map<String, dynamic> json) => PopularSearch(
        label: json['label'] as String? ?? '',
        href: json['href'] as String? ?? '',
      );
}

class PageContent {
  final String title;
  final String body;
  final String lastUpdated;
  final String metaTitle;
  final String metaDescription;

  const PageContent({
    this.title = '',
    this.body = '',
    this.lastUpdated = '',
    this.metaTitle = '',
    this.metaDescription = '',
  });

  factory PageContent.fromJson(Map<String, dynamic> json) => PageContent(
        title: json['title'] as String? ?? '',
        body: json['body'] as String? ?? '',
        lastUpdated: json['lastUpdated'] as String? ?? '',
        metaTitle: json['metaTitle'] as String? ?? '',
        metaDescription: json['metaDescription'] as String? ?? '',
      );
}

class PageMeta {
  final String title;
  final String subtitle;
  final String footerNote;
  final String metaTitle;
  final String metaDescription;

  const PageMeta({
    this.title = '',
    this.subtitle = '',
    this.footerNote = '',
    this.metaTitle = '',
    this.metaDescription = '',
  });

  factory PageMeta.fromJson(Map<String, dynamic> json) => PageMeta(
        title: json['title'] as String? ?? '',
        subtitle: json['subtitle'] as String? ?? '',
        footerNote: json['footerNote'] as String? ?? '',
        metaTitle: json['metaTitle'] as String? ?? '',
        metaDescription: json['metaDescription'] as String? ?? '',
      );
}

class Footer {
  final String brandTagline;
  final Map<String, String> sectionTitles;
  final FooterLink findbyCityAll;
  final FooterLink courtsAll;
  final int courtsListLimit;
  final int qaTopicsLimit;
  final List<FooterLink> legalResources;
  final List<FooterLink> bottomLinks;
  final List<dynamic> cityPracticeLinks;

  const Footer({
    this.brandTagline = '',
    this.sectionTitles = const {},
    this.findbyCityAll = const FooterLink(),
    this.courtsAll = const FooterLink(),
    this.courtsListLimit = 6,
    this.qaTopicsLimit = 6,
    this.legalResources = const [],
    this.bottomLinks = const [],
    this.cityPracticeLinks = const [],
  });

  factory Footer.fromJson(Map<String, dynamic> json) => Footer(
        brandTagline: json['brandTagline'] as String? ?? '',
        sectionTitles: (json['sectionTitles'] as Map<String, dynamic>?)
                ?.map((k, v) => MapEntry(k, v as String)) ??
            {},
        findbyCityAll: FooterLink.fromJson(
            json['findByCityAll'] as Map<String, dynamic>? ?? {}),
        courtsAll: FooterLink.fromJson(
            json['courtsAll'] as Map<String, dynamic>? ?? {}),
        courtsListLimit: json['courtsListLimit'] as int? ?? 6,
        qaTopicsLimit: json['qaTopicsLimit'] as int? ?? 6,
        legalResources: (json['legalResources'] as List<dynamic>?)
                ?.map((e) =>
                    FooterLink.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        bottomLinks: (json['bottomLinks'] as List<dynamic>?)
                ?.map((e) =>
                    FooterLink.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        cityPracticeLinks: json['cityPracticeLinks'] as List<dynamic>? ?? [],
      );
}

class FooterLink {
  final String label;
  final String href;

  const FooterLink({this.label = '', this.href = ''});

  factory FooterLink.fromJson(Map<String, dynamic> json) => FooterLink(
        label: json['label'] as String? ?? '',
        href: json['href'] as String? ?? '',
      );
}

class Language {
  final String code;
  final String label;

  Language({this.code = '', this.label = ''});

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        code: json['code'] as String? ?? '',
        label: json['label'] as String? ?? '',
      );
}

class NavItem {
  final String label;
  final String href;
  final String? mega;

  NavItem({this.label = '', this.href = '', this.mega});

  factory NavItem.fromJson(Map<String, dynamic> json) => NavItem(
        label: json['label'] as String? ?? '',
        href: json['href'] as String? ?? '',
        mega: json['mega'] as String?,
      );
}
