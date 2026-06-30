import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart' as search_ctrl;
import '../theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _textCtrl;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textCtrl = TextEditingController();
    _focusNode = FocusNode()..requestFocus();
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'lawyer':
        return Icons.gavel;
      case 'article':
        return Icons.article_outlined;
      case 'qa':
        return Icons.forum_outlined;
      case 'act':
        return Icons.book_outlined;
      case 'court':
        return Icons.account_balance_outlined;
      case 'guide':
        return Icons.menu_book_outlined;
      default:
        return Icons.search;
    }
  }

  String _sectionLabel(String type) {
    switch (type) {
      case 'lawyer':
        return 'Lawyers';
      case 'article':
        return 'Articles';
      case 'qa':
        return 'Q&A';
      case 'act':
        return 'Acts';
      case 'court':
        return 'Courts';
      case 'guide':
        return 'Guides';
      default:
        return type;
    }
  }

  void _navigateToResult(context, String type, String href) {
    if (href.isEmpty) return;
    final slug = href.split('/').last;
    final route = switch (type) {
      'lawyer' => '/lawyers/$slug',
      'article' => '/articles/$slug',
      'qa' => '/qa/$slug',
      'court' => '/court/$slug',
      'act' => '/acts/$slug',
      'guide' => '/guides/$slug',
      _ => href,
    };
    Navigator.of(context).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<search_ctrl.SearchController>();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _textCtrl,
          focusNode: _focusNode,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search lawyers, articles, Q&A...',
            border: InputBorder.none,
            filled: false,
            contentPadding: EdgeInsets.zero,
            suffixIcon: Obx(() => ctrl.query.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _textCtrl.clear();
                      ctrl.clearSearch();
                      _focusNode.requestFocus();
                    },
                  )
                : const SizedBox()),
          ),
          onChanged: (q) {
            if (q.length >= 2) {
              ctrl.search(q);
            } else {
              ctrl.clearSearch();
            }
          },
        ),
      ),
      body: Obx(() {
        if (ctrl.query.value.length < 2) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search, size: 64, color: AppColors.outline.withOpacity(0.4)),
                  const SizedBox(height: 16),
                  Text(
                    'Search across lawyers, articles, Q&A, legal resources...',
                    textAlign: TextAlign.center,
                    style: AppText.bodyMd.copyWith(color: AppColors.outline),
                  ),
                ],
              ),
            ),
          );
        }

        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final results = ctrl.results;
        if (results.isEmpty) {
          return Center(
            child: Text('No results found for "${ctrl.query}".',
                style: AppText.bodyMd.copyWith(color: AppColors.outline)),
          );
        }

        final grouped = <String, List>{};
        for (final r in results) {
          grouped.putIfAbsent(r.type, () => []).add(r);
        }

        final typeOrder = ['lawyer', 'article', 'qa', 'act', 'court', 'guide'];

        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            for (final type in typeOrder)
              if (grouped.containsKey(type)) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                  child: Text(_sectionLabel(type),
                      style: AppText.labelCaps.copyWith(color: AppColors.secondary)),
                ),
                for (final r in grouped[type]!)
                  ListTile(
                    leading: Icon(_iconForType(r.type), color: AppColors.primary),
                    title: Text(r.title, style: AppText.titleLg),
                    subtitle: r.excerpt.isNotEmpty
                        ? Text(r.excerpt, style: AppText.bodySm, maxLines: 1, overflow: TextOverflow.ellipsis)
                        : null,
                    trailing: const Icon(Icons.chevron_right, size: 18),
                    onTap: () => _navigateToResult(context, r.type, r.href),
                  ),
              ],
          ],
        );
      }),
    );
  }
}
