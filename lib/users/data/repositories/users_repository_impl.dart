import 'package:bloc_users_demo/users/data/datasources/users_remote_datasource.dart';
import 'package:bloc_users_demo/users/data/mappers/UserDtoMapper.dart';
import 'package:bloc_users_demo/users/domain/entities/UserEntity.dart';
import 'package:bloc_users_demo/users/domain/repositories/users_repository.dart';

class UsersRepositoryImpl implements UserRepository {
  
  final UsersRemoteDatasource remoteDatasource;


  UsersRepositoryImpl({
    required this.remoteDatasource,
  });

  @override
  Future<List<UserEntity>> getUsers() async {
    final userDtos = await remoteDatasource.getUsers();
    return userDtos.map((dto) => dto.toEntity()).toList();
  }
}