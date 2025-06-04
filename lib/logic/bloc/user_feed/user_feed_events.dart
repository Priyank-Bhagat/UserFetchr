import 'package:flutter/cupertino.dart';

@immutable
abstract class UserFeedEvents {}

class GetUserFeedEvent extends UserFeedEvents {
  String userId;
  GetUserFeedEvent({required this.userId});

}


