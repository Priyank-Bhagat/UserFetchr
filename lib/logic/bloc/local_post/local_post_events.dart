

import 'package:user_fetchr/data/local_post_model.dart';

abstract class LocalPostEvent {}

class LoadPostsEvent extends LocalPostEvent {}

class AddPostEvent extends LocalPostEvent {
  final LocalPostModel post;
  AddPostEvent(this.post);
}
