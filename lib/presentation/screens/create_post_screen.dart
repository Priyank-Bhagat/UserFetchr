import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_fetchr/data/local_post_model.dart';
import 'package:user_fetchr/logic/bloc/local_post/local_post_bloc.dart';
import 'package:user_fetchr/logic/bloc/local_post/local_post_events.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  void _submitPost() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final body = _bodyController.text.trim();
      debugPrint('New Post:\nTitle: $title\nBody: $body');
      final post = LocalPostModel(
        title: _titleController.text,
        body: _bodyController.text,
      );
      context.read<LocalPostBloc>().add(AddPostEvent(post));

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Post created locally')));

      _titleController.clear();
      _bodyController.clear();

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Create Post'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Field
                Text('Post Title', style: textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _titleController,
                  style: TextStyle(color: Colors.black54),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Enter a title'
                      : null,
                  decoration: InputDecoration(
                    hintText: 'Enter post title',
                    filled: true,
                    fillColor: colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Body Field
                Text('Post Body', style: textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _bodyController,
                  style: TextStyle(color: Colors.black54),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Enter post body'
                      : null,
                  maxLines: 8,
                  minLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Write your post here...',
                    filled: true,
                    fillColor: colorScheme.surface,
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _submitPost,
                    icon: const Icon(Icons.send),
                    label: const Text('Post'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: colorScheme.onPrimary,
                      backgroundColor: colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
