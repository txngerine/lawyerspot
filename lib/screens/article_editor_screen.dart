import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/article_controller.dart';
import '../models/article_model.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ArticleEditorScreen extends StatefulWidget {
  final Article? article;
  const ArticleEditorScreen({super.key, this.article});

  @override
  State<ArticleEditorScreen> createState() => _ArticleEditorScreenState();
}

class _ArticleEditorScreenState extends State<ArticleEditorScreen> {
  final _controller = Get.find<ArticleController>();
  final _titleController = TextEditingController();
  final _excerptController = TextEditingController();
  final _categoryController = TextEditingController();
  final _contentController = TextEditingController();
  final _imageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _status = 'published';

  bool get _isEditing => widget.article != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      final a = widget.article!;
      _titleController.text = a.title;
      _excerptController.text = a.excerpt;
      _categoryController.text = a.category;
      _contentController.text = a.content;
      _imageController.text = a.image;
      _status = a.status;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _excerptController.dispose();
    _categoryController.dispose();
    _contentController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final data = {
      'title': _titleController.text.trim(),
      'excerpt': _excerptController.text.trim(),
      'category': _categoryController.text.trim(),
      'content': _contentController.text.trim(),
      'image': _imageController.text.trim(),
      'status': _status,
    };

    if (_isEditing) {
      await _controller.updateArticle(widget.article!.slug, data);
      if (_controller.errorMessage.value == null) {
        Get.back();
        Get.snackbar('Success', 'Article updated', snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      await _controller.createArticle(data);
      if (_controller.errorMessage.value == null) {
        Get.back();
        Get.snackbar('Success', 'Article created', snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrandAppBar(
        showBack: true,
        title: _isEditing ? 'Edit Article' : 'Create Article',
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_controller.errorMessage.value != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_controller.errorMessage.value != null) {
              Get.snackbar('Error', _controller.errorMessage.value!, snackPosition: SnackPosition.BOTTOM);
              _controller.errorMessage.value = null;
            }
          });
        }
        return SafeArea(
          top: false,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (v) => v == null || v.trim().isEmpty ? 'Title is required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _excerptController,
                  decoration: const InputDecoration(labelText: 'Excerpt'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _imageController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contentController,
                  decoration: const InputDecoration(labelText: 'Content'),
                  maxLines: 10,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text('Status: ', style: AppText.titleLg),
                    const SizedBox(width: 12),
                    ChoiceChip(
                      label: const Text('Draft'),
                      selected: _status == 'draft',
                      onSelected: (_) => setState(() => _status = 'draft'),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Published'),
                      selected: _status == 'published',
                      onSelected: (_) => setState(() => _status = 'published'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                GoldButton(
                  label: _isEditing ? 'Update Article' : 'Save Article',
                  onPressed: _save,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
