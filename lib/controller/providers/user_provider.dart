import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserState extends Equatable {
  final String userId;
  final String username;
  final String profilePicture;
  const UserState({
    required this.userId,
    required this.username,
    required this.profilePicture,
  });

  UserState copyWith({
    String? userId,
    String? username,
    String? profilePicture,
  }) {
    return UserState(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        username,
        profilePicture,
      ];
}

class UserProvider extends StateNotifier<UserState> {
  UserProvider()
      : super(const UserState(
          userId: '',
          username: '',
          profilePicture: '',
        ));
  void getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final username = prefs.getString('username');
    final profilePicture = prefs.getString('profilePicture');
    if (userId != null && userId.isNotEmpty) {
      state = UserState(
          userId: userId,
          username: username ?? '',
          profilePicture: profilePicture ?? '');
    }
  }
}

final getUserProvider = StateNotifierProvider<UserProvider, UserState>(
  (ref) {
    return UserProvider();
  },
);
