import 'dart:async';

import 'package:bookly_app/constants/constants.dart';
import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/controller/services/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginState extends Equatable {
  final Exception? error;
  final String? message;
  final bool isLoading;

  const LoginState({
    this.error,
    this.message,
    this.isLoading = false,
  });

  LoginState copyWith({
    bool? isLoading,
    Exception? error,
    String? message,
  }) {
    return LoginState(
      error: error,
      message: message,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [message, isLoading, error];
}

class LoginProvider extends StateNotifier<LoginState> {
  final AuthService _authService;
  final SharedPreferences prefs;
  LoginProvider(this._authService, this.prefs) : super(const LoginState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _authService.login(email, password);
      if (user != null) {
        await prefs.setString(Constants.userId, user.id);
        await prefs.setString(Constants.username, user.username);
        await prefs.setString(Constants.profilePicture, user.profilePicture);
      }
      state = state.copyWith(isLoading: false, message: 'Login successful');
    } on Exception catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }
}

final loginProvider =
    StateNotifierProvider.autoDispose<LoginProvider, LoginState>((ref) {
  final authService = ref.read(authServiceProvider);
  final prefs = ref.read(prefsProvider);
  return LoginProvider(authService, prefs);
});
