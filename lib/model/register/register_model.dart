import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterModel extends Equatable {
  final String message;
  final String userId;

  final String username;

  final String email;

  final String phone;

  final bool isAdmin;
  final String profilePicture;
  final String emailConfirmationLink;

  const RegisterModel({
    required this.message,
    required this.userId,
    required this.username,
    required this.email,
    required this.phone,
    required this.isAdmin,
    required this.profilePicture,
    required this.emailConfirmationLink,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);

  @override
  List<Object?> get props => [
        message,
        userId,
        username,
        email,
        phone,
        isAdmin,
        profilePicture,
        emailConfirmationLink
      ];
}
