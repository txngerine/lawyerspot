import 'package:get/get.dart';
import '../models/cms_model.dart';
import '../models/lawyer_model.dart';
import '../models/article_model.dart';
import '../models/qa_model.dart';
import '../models/search_result_model.dart';
import 'cms_controller.dart';

class SearchController extends GetxController {
  final query = ''.obs;
  final results = <SearchResult>[].obs;
  final isLoading = false.obs;
  final selectedType = 'All'.obs;

  void search(String q) {
    query.value = q;
    if (q.trim().isEmpty) {
      results.clear();
      return;
    }

    isLoading.value = true;
    final term = q.toLowerCase();
    final cms = Get.find<CmsController>().cmsData.value;
    final list = <SearchResult>[];

    if (cms != null) {
      for (final l in cms.lawyers) {
        if (list.length >= 40) break;
        if (_matchesLawyer(l, term)) {
          list.add(SearchResult(
            type: 'lawyer',
            title: l.name,
            excerpt: '${l.practice} · ${l.location}',
            href: '/lawyer/${l.slug}',
          ));
        }
      }

      for (final a in cms.articles) {
        if (list.length >= 40) break;
        if (a.status == 'published' && _matchesArticle(a, term)) {
          list.add(SearchResult(
            type: 'article',
            title: a.title,
            excerpt: a.excerpt,
            href: '/articles/${a.slug}',
          ));
        }
      }

      for (final qp in cms.qaPosts) {
        if (list.length >= 40) break;
        if (qp.status == 'published' && _matchesQaPost(qp, term)) {
          list.add(SearchResult(
            type: 'qa',
            title: qp.title,
            excerpt: qp.excerpt,
            href: '/qa/${qp.slug}',
          ));
        }
      }

      for (final act in cms.siteContent.acts) {
          if (list.length >= 40) break;
          if (_matchesAct(act, term)) {
            list.add(SearchResult(
              type: 'act',
              title: act.title,
              excerpt: act.act,
              href: '/acts/${act.slug}',
            ));
          }
        }

      for (final court in cms.siteContent.courts) {
          if (list.length >= 40) break;
          if (_matchesCourt(court, term)) {
            list.add(SearchResult(
              type: 'court',
              title: court.name,
              excerpt: court.city,
              href: '/courts/${court.slug}',
            ));
          }
        }

      for (final guide in cms.siteContent.legalGuides) {
          if (list.length >= 40) break;
          if (_matchesLegalGuide(guide, term)) {
            list.add(SearchResult(
              type: 'guide',
              title: guide.title,
              excerpt: guide.category,
              href: '/guides/${guide.slug}',
            ));
          }
        }
    }

    results.value = list;
    isLoading.value = false;
  }

  bool _matchesLawyer(Lawyer l, String term) {
    return l.name.toLowerCase().contains(term) ||
        l.location.toLowerCase().contains(term) ||
        l.practice.toLowerCase().contains(term) ||
        l.firm.toLowerCase().contains(term) ||
        l.bio.toLowerCase().contains(term) ||
        l.specialization.any((s) => s.toLowerCase().contains(term));
  }

  bool _matchesArticle(Article a, String term) {
    return a.title.toLowerCase().contains(term) ||
        a.excerpt.toLowerCase().contains(term) ||
        a.category.toLowerCase().contains(term) ||
        a.content.toLowerCase().contains(term);
  }

  bool _matchesQaPost(QaPost q, String term) {
    return q.title.toLowerCase().contains(term) ||
        q.excerpt.toLowerCase().contains(term) ||
        q.category.toLowerCase().contains(term) ||
        q.content.toLowerCase().contains(term);
  }

  bool _matchesAct(ActEntry a, String term) {
    return a.title.toLowerCase().contains(term) ||
        a.act.toLowerCase().contains(term) ||
        a.body.toLowerCase().contains(term);
  }

  bool _matchesCourt(CourtEntry c, String term) {
    return c.name.toLowerCase().contains(term) ||
        c.city.toLowerCase().contains(term) ||
        c.body.toLowerCase().contains(term);
  }

  bool _matchesLegalGuide(LegalGuide g, String term) {
    return g.title.toLowerCase().contains(term) ||
        g.category.toLowerCase().contains(term);
  }

  void clearSearch() {
    query.value = '';
    results.clear();
  }

  void searchByType(String type) {
    selectedType.value = type;
    if (type == 'All') return;
    results.value = results.where((r) => r.type == type).toList();
  }
}
