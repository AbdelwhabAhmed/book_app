import 'dart:async';
import 'package:bookly_app/helpers/http_client.dart';
import 'package:bookly_app/helpers/networking.dart';
import 'package:bookly_app/model/login/login_model.dart';
import 'package:bookly_app/model/register/register_model.dart';

class AuthService {
  final ApiClient client;
  RegisterModel? user;
  LoginModel? loginUser;
  AuthService(this.client);

  Future<RegisterModel?> register(
      String email, String phone, String username, String password) async {
    final response = await client.post(Endpoints.register, body: {
      'Email': email,
      'Phone': phone,
      'Username': username,
      'Password': password,
    });
    final data = response.data as Map<String, dynamic>;
    return RegisterModel.fromJson(data);
  }

  Future<LoginModel?> login(String email, String password) async {
    final response = await client.post(Endpoints.login, body: {
      'Email': email,
      'Password': password,
    });
    final data = response.data as Map<String, dynamic>;
    final user = data['user'] as Map<String, dynamic>;
    return LoginModel.fromJson(user);
  }

  // Future<UserModel?> getUser(String userId) async {
  //   final response = await client.get(Endpoints.getUser(userId));
  //   return UserModel.fromJson(response.data['user'] ?? response.data);
  // }
}
