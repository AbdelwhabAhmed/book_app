// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      profilePicture: json['profilePicture'] as String,
      lastMessage: json['lastMessage'] as String,
      timeStamp: DateTime.parse(json['timeStamp'] as String),
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'profilePicture': instance.profilePicture,
      'lastMessage': instance.lastMessage,
      'timeStamp': instance.timeStamp.toIso8601String(),
    };
