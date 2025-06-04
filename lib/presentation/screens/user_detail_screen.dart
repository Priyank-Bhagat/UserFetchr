import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_fetchr/logic/bloc/user_feed/user_feed_bloc.dart';
import 'package:user_fetchr/logic/bloc/user_feed/user_feed_states.dart';

import '../../data/user_posts_model.dart';
import '../../data/user_todos_model.dart';
import '../../logic/bloc/user_feed/user_feed_events.dart';

class UserDetailScreen extends StatefulWidget {
  final String name;
  final String email;
  final String id;
  final String avatarUrl;

  const UserDetailScreen({
    super.key,
    required this.name,
    required this.email,
    required this.id,
    required this.avatarUrl,
  });

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    context.read<UserFeedBloc>().add(GetUserFeedEvent(userId: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Details'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Posts'),
              Tab(text: 'Todos'),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundImage: NetworkImage(widget.avatarUrl),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.name, style: textTheme.titleLarge),
                            const SizedBox(height: 4),
                            Text(
                              widget.email,
                              style: textTheme.bodyMedium?.copyWith(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              BlocBuilder<UserFeedBloc, UserFeedStates>(
                builder: (context, state) {
                  if (state is UserFeedLoading) {
                    return Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is UserFeedSuccess) {
                    return Expanded(
                      child: TabBarView(
                        children: [
                          (state.userPostsModel.posts ?? []).isEmpty
                              ? Center(child: Text('No Posts found.'))
                              : _buildPostsList(context, state.userPostsModel),

                          (state.userTodosModel.todos ?? []).isEmpty
                              ? Center(child: Text('No Todos found.'))
                              : _buildTodosList(context, state.userTodosModel),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Something went wrong!'),
                        Text('Check your internet connectivity'),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostsList(BuildContext context, UserPostsModel postsList) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return RefreshIndicator(
      onRefresh: ()async{
        context.read<UserFeedBloc>().add(GetUserFeedEvent(userId: widget.id));
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: postsList.posts!.length,
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
                  postsList.posts![index].title.toString(),
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  postsList.posts![index].body.toString(),
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTodosList(BuildContext context, UserTodosModel todosList) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return RefreshIndicator(
      onRefresh: ()async{
        context.read<UserFeedBloc>().add(GetUserFeedEvent(userId: widget.id));
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: todosList.todos!.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  todosList.todos![index].completed!
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: todosList.todos![index].completed!
                      ? colorScheme.primary
                      : Colors.white60,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    todosList.todos![index].todo.toString(),
                    style: textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
