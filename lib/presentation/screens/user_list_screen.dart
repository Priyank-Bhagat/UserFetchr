import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_fetchr/logic/bloc/user_list/user_list_bloc.dart';
import 'package:user_fetchr/logic/bloc/user_list/user_list_events.dart';
import 'package:user_fetchr/logic/bloc/user_list/user_list_states.dart';
import 'package:user_fetchr/presentation/screens/create_post_screen.dart';
import 'package:user_fetchr/presentation/screens/local_posts_screen.dart';
import 'package:user_fetchr/presentation/screens/user_detail_screen.dart';

import '../../logic/bloc/cubits/theme_cubit.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isOpen = false;

  @override
  void initState() {
    context.read<UserListBloc>().add(GetUserListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isOpen) ...[
            FloatingActionButton(
              heroTag: "hero1",
              mini: true,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePostScreen()),
                );
              },
              child: Icon(Icons.post_add),
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              heroTag: "hero2",
              mini: true,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocalPostsScreen()),
                );
              },
              child: Icon(Icons.view_list),
            ),
            SizedBox(height: 10),
          ],
          FloatingActionButton(
            heroTag: "heromain",
            onPressed: () => setState(() => _isOpen = !_isOpen),
            child: Icon(_isOpen ? Icons.close : Icons.add),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                onChanged: (query) {
                  context.read<UserListBloc>().add(
                    SearchUserEvent(query: query),
                  );
                },
                style: TextStyle(color: theme.colorScheme.onPrimary),
                decoration: InputDecoration(
                  hintText: 'Search users...',
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<UserListBloc, UserListStates>(
                builder: (context, state) {
                  if (state is UserListLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is UserListSuccess) {
                    final users = state.userModel.users ?? [];
                    if (users.isEmpty) {
                      return Center(child: Text('No users found.'));
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<UserListBloc>().add(GetUserListEvent());
                      },
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: state.userModel.users!.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          var usersList = state.userModel.users![index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserDetailScreen(
                                    name:
                                        "${usersList.firstName} ${usersList.lastName}",
                                    email: usersList.email.toString(),
                                    avatarUrl: usersList.image.toString(),
                                    id: usersList.id.toString(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 12),
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundImage: NetworkImage(
                                        usersList.image.toString(),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            usersList.firstName.toString() +
                                                usersList.lastName.toString(),
                                            style: textTheme.titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            usersList.email.toString(),
                                            style: textTheme.bodySmall
                                                ?.copyWith(),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color: theme.iconTheme.color,
                                    ),
                                    const SizedBox(width: 12),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
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
            ),
          ],
        ),
      ),
    );
  }
}
