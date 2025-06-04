import 'package:bloc/bloc.dart';
import 'package:user_fetchr/logic/bloc/user_list/user_list_events.dart';
import 'package:user_fetchr/logic/bloc/user_list/user_list_states.dart';
import 'package:user_fetchr/logic/repository/repository.dart';

import '../../../data/user_model.dart';

class UserListBloc extends Bloc<UserListEvents, UserListStates> {
  List<Users> _allUsers = [];
  List<Users> _filteredUsers = [];

  UserListBloc() : super(UserListInitial()) {
    on<UserListEvents>((event, emit) async {
      if (event is GetUserListEvent) {
        emit.call(UserListLoading());

        try {
          final UserModel model = await Repository().getUserNet();
          _allUsers = model.users ?? [];
          _filteredUsers = List.from(_allUsers);
          emit.call(
            UserListSuccess(userModel: model.copyWith(users: _filteredUsers)),
          );
        } catch (e) {
          emit.call(UserListFailure());
          print(e);
        }
      }
      if (event is SearchUserEvent) {
        final query = event.query.toLowerCase();

        emit.call(UserListLoading());

        _filteredUsers = _allUsers.where((user) {
          return (user.firstName?.toLowerCase().contains(query) ?? false) ||
              (user.lastName?.toLowerCase().contains(query) ?? false) ||
              (user.email?.toLowerCase().contains(query) ?? false) ||
              (user.username?.toLowerCase().contains(query) ?? false);
        }).toList();

        emit.call(
          UserListSuccess(
            userModel: UserModel(
              users: _filteredUsers,
              total: _filteredUsers.length,
              skip: 0,
              limit: _filteredUsers.length,
            ),
          ),
        );
      }
    });
  }
}
