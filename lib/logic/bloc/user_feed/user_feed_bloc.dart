import 'package:bloc/bloc.dart';
import 'package:user_fetchr/data/user_posts_model.dart';
import 'package:user_fetchr/data/user_todos_model.dart';
import 'package:user_fetchr/logic/bloc/user_feed/user_feed_events.dart';
import 'package:user_fetchr/logic/bloc/user_feed/user_feed_states.dart';

import '../../repository/repository.dart';

class UserFeedBloc extends Bloc<UserFeedEvents, UserFeedStates> {
  UserFeedBloc() : super(UserFeedInitial()) {
    on<GetUserFeedEvent>((event, emit) async {
      emit.call(UserFeedLoading());

      try {
        final UserPostsModel postsModel = await Repository().getUserPosts(
          event.userId,
        );
        final UserTodosModel todosModel = await Repository().getUserTodos(
          event.userId,
        );
        emit.call(
          UserFeedSuccess(
            userPostsModel: postsModel,
            userTodosModel: todosModel,
          ),
        );
      } catch (e) {
        emit.call(UserFeedFailure());
        print(e);
      }
    });
  }
}
