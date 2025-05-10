import 'dart:async';

import 'package:bookly_app/constants/constants.dart';
import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/controller/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterState extends Equatable {
  final Exception? error;
  final String? message;
  final bool isLoading;

  const RegisterState({
    this.error,
    this.message,
    this.isLoading = false,
  });

  RegisterState copyWith({
    bool? isLoading,
    Exception? error,
    String? message,
  }) {
    return RegisterState(
      error: error,
      message: message,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [message, isLoading, error];
}

class RegisterProvider extends StateNotifier<RegisterState> {
  final AuthService _authService;
  final SharedPreferences prefs;
  RegisterProvider(this._authService, this.prefs)
      : super(const RegisterState());

  Future<void> register(
      String email, String phone, String username, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      final user =
          await _authService.register(email, phone, username, password);
      if (user != null) {
        await prefs.setString(Constants.userId, user.userId);
        await prefs.setString(Constants.username, user.username);
        await prefs.setString(Constants.profilePicture, user.profilePicture);
      }

      state =
          state.copyWith(isLoading: false, message: 'Registration successful');
    } on DioException catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }
}

final registerProvider =
    StateNotifierProvider.autoDispose<RegisterProvider, RegisterState>((ref) {
  final authService = ref.read(authServiceProvider);
  final prefs = ref.read(prefsProvider);
  return RegisterProvider(authService, prefs);
});
