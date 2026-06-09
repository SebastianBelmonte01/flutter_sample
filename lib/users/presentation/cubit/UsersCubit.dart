import 'package:bloc_users_demo/users/domain/usecases/GetUsersUseCase.dart';
import 'package:bloc_users_demo/users/presentation/cubit/users_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersCubit extends Cubit<UsersState> {
  final GetUsersUseCase _getUsersUseCase;

  UsersCubit({
    required this._getUsersUseCase,
  })  : super(UsersState.initial());

  Future<void> fetchUsers() async {
    emit(UsersState.loading());
    try {
      final users = await _getUsersUseCase();
      if (users.isEmpty) {
        emit(UsersState.empty());
      } else {
        emit(UsersState.success(users));
      }
    } catch (e) {
      emit(UsersState.failure(e.toString()));
    }
  }
}