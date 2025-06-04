import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_fetchr/logic/bloc/local_post/local_post_events.dart';
import '../../../data/local_post_model.dart';
import 'local_post_states.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class LocalPostBloc extends Bloc<LocalPostEvent, LocalPostState> {
  LocalPostBloc() : super(PostInitialState()) {
    on<LoadPostsEvent>(_onLoadPosts);
    on<AddPostEvent>(_onAddPost);
  }

  Future<void> _onLoadPosts(LoadPostsEvent event, Emitter<LocalPostState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('posts') ?? [];
    final posts = data.map((e) => LocalPostModel.fromJson(json.decode(e))).toList();
    emit(PostLoadedState(posts));
  }

  Future<void> _onAddPost(AddPostEvent event, Emitter<LocalPostState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('posts') ?? [];
    final newPost = json.encode(event.post.toJson());
    data.add(newPost);
    await prefs.setStringList('posts', data);
    add(LoadPostsEvent());
  }
}
