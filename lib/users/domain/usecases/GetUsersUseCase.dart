import 'package:bloc_users_demo/users/domain/entities/UserEntity.dart';
import 'package:bloc_users_demo/users/domain/repositories/users_repository.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase({
    required this.repository,
  });

  Future<List<UserEntity>> call() async {
    return await repository.getUsers();
  }
}