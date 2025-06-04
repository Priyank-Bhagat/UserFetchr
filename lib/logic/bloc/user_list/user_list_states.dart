import 'package:flutter/cupertino.dart';
import 'package:user_fetchr/data/user_model.dart';

@immutable
abstract class UserListStates {}

class UserListInitial extends UserListStates {}

class UserListLoading extends UserListStates {}

class UserListSuccess extends UserListStates {
  final UserModel userModel;
  UserListSuccess({required this.userModel});
}


class UserListFailure extends UserListStates {}
