import 'package:flutter/cupertino.dart';
import 'package:user_fetchr/data/user_posts_model.dart';
import '../../../data/user_todos_model.dart';

@immutable
abstract class UserFeedStates {}

class UserFeedInitial extends UserFeedStates {}

class UserFeedLoading extends UserFeedStates {}

class UserFeedSuccess extends UserFeedStates {
  final UserPostsModel userPostsModel;
  final UserTodosModel userTodosModel;
  UserFeedSuccess({required this.userPostsModel, required this.userTodosModel});
}

class UserFeedFailure extends UserFeedStates {}
