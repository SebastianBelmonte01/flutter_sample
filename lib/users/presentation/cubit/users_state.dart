import 'package:bloc_users_demo/users/domain/entities/UserEntity.dart';

enum UsersStatus { 
  initial,
  loading,
  success,
  failure,
  empty
}
class UsersState {
  final UsersStatus status;
  final List<UserEntity> users;
  final String? errorMessage;

  const UsersState._({
    required this.status,
    this.users = const [],
    this.errorMessage,
  });

  const UsersState.initial() : this._(
    status: UsersStatus.initial,
    users: const [],
    errorMessage: null,
  );

  const UsersState.loading() : this._(
    status: UsersStatus.loading,
    users: const [],
    errorMessage: null,
  );

  const UsersState.success(List<UserEntity> users) : this._(
    status: UsersStatus.success,
    users: users,
    errorMessage: null,
  );

  const UsersState.failure(String errorMessage) : this._(
    status: UsersStatus.failure,
    users: const [],
    errorMessage: errorMessage,
  );

  const UsersState.empty() : this._(
    status: UsersStatus.empty,
    users: const [],
    errorMessage: null,
  );

  
}