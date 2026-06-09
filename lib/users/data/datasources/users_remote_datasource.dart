import 'dart:convert';

import 'package:bloc_users_demo/users/data/models/UserDto.dart';
import 'package:http/http.dart' as http;


class UsersRemoteDatasource {
  Future<List<UserDto>> getUsers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => UserDto.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load users');
    } 
  }
}