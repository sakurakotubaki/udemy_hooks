import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:udemy_hooks/useFuture/user_model.dart';

class UserDataSource {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  Future<List<UserModel>> getUser() async {
    try {
      debugPrint('Starting API request...');
      List<UserModel> users = [];
      final response = await _dio.get('/users');
      debugPrint('Response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        debugPrint('Response data length: ${data.length}');
        debugPrint('Response data: $data');
        users = data.map((json) => UserModel.fromJson(json)).toList();
        debugPrint('Parsed ${users.length} users');
      } else {
        throw Exception('Failed to load users: status ${response.statusCode}');
      }
      return users;
    } on DioException catch (e) {
      debugPrint('DioException: ${e.type} - ${e.message}');
      throw Exception('Failed to load users: ${e.message}');
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw Exception('Unexpected error: $e');
    }
  }
}
