import 'package:bloc_users_demo/users/domain/entities/UserEntity.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUsers();
}