import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:user_fetchr/data/user_model.dart';
import 'package:user_fetchr/data/user_posts_model.dart';

import '../../data/user_todos_model.dart';

class Repository {
  final String _baseUrl = "https://dummyjson.com";

  Future<UserModel> getUserNet() async {
    final response = await http.get(
      Uri.parse("$_baseUrl/users"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    throw UnimplementedError();
  }

  Future<UserPostsModel> getUserPosts(String userId) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/posts/user/$userId"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return UserPostsModel.fromJson(jsonDecode(response.body));
    }
    throw UnimplementedError();
  }

  Future<UserTodosModel> getUserTodos(String userId) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/todos/user/$userId"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return UserTodosModel.fromJson(jsonDecode(response.body));
    }
    throw UnimplementedError();
  }
}
