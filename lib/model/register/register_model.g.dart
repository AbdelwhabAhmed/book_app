// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterModel _$RegisterModelFromJson(Map<String, dynamic> json) =>
    RegisterModel(
      message: json['message'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      isAdmin: json['isAdmin'] as bool,
      profilePicture: json['profilePicture'] as String,
      emailConfirmationLink: json['emailConfirmationLink'] as String,
    );

Map<String, dynamic> _$RegisterModelToJson(RegisterModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'userId': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'isAdmin': instance.isAdmin,
      'profilePicture': instance.profilePicture,
      'emailConfirmationLink': instance.emailConfirmationLink,
    };
