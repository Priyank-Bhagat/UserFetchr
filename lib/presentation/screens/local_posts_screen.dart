import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_fetchr/logic/bloc/local_post/local_post_bloc.dart';
import 'package:user_fetchr/logic/bloc/local_post/local_post_events.dart';
import 'package:user_fetchr/logic/bloc/local_post/local_post_states.dart';

class LocalPostsScreen extends StatefulWidget {
  const LocalPostsScreen({super.key});

  @override
  State<LocalPostsScreen> createState() => _LocalPostsScreenState();
}

class _LocalPostsScreenState extends State<LocalPostsScreen> {
  @override
  void initState() {
    context.read<LocalPostBloc>().add(LoadPostsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Local Posts')),
      body: SafeArea(
        child: BlocBuilder<LocalPostBloc, LocalPostState>(
          builder: (context, state) {
            if (state is PostLoadedState) {
              return RefreshIndicator(
                onRefresh: () async {},
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: state.posts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.posts[index].title,
                            style: textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.posts[index].body.toString(),
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else {
              return Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }
}
