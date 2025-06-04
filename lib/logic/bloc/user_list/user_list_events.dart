import 'package:flutter/cupertino.dart';

@immutable
abstract class UserListEvents {}

class GetUserListEvent extends UserListEvents {}

class SearchUserEvent extends UserListEvents {
  final String query;
  SearchUserEvent({required this.query});
}
