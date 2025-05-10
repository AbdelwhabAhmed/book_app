import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends Equatable {
  final String id;
  final String email;
  final String username;
  final bool isAdmin;
  final String profilePicture;

  const LoginModel({
    required this.id,
    required this.email,
    required this.username,
    required this.isAdmin,
    required this.profilePicture,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  @override
  List<Object?> get props => [id, email, username, isAdmin, profilePicture];
}
