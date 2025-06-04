import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_fetchr/logic/bloc/local_post/local_post_bloc.dart';
import 'package:user_fetchr/logic/bloc/user_feed/user_feed_bloc.dart';
import 'package:user_fetchr/logic/bloc/user_list/user_list_bloc.dart';
import 'package:user_fetchr/presentation/constants/theme.dart';
import 'package:user_fetchr/presentation/screens/user_list_screen.dart';
import 'logic/bloc/cubits/theme_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => UserListBloc()),
        BlocProvider(create: (context) => UserFeedBloc()),
        BlocProvider(create: (context) => LocalPostBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          home: UserListScreen(),
        );
      },
    );
  }
}
