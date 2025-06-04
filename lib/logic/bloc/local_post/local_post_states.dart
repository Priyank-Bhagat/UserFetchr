
import 'package:user_fetchr/data/local_post_model.dart';

abstract class LocalPostState {}

class PostInitialState extends LocalPostState {}


class PostLoadedState extends LocalPostState {
  final List<LocalPostModel> posts;
  PostLoadedState(this.posts);
}
