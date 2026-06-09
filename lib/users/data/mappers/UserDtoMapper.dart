import 'package:bloc_users_demo/users/data/models/UserDto.dart';
import 'package:bloc_users_demo/users/domain/entities/UserEntity.dart';

extension UserDtoMapper on UserDto {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
    );
  }
}