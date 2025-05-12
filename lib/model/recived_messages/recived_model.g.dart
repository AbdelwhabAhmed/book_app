// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recived_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecievedMessages _$RecievedMessagesFromJson(Map<String, dynamic> json) =>
    RecievedMessages(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      sentAt: DateTime.parse(json['sentAt'] as String),
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
    );

Map<String, dynamic> _$RecievedMessagesToJson(RecievedMessages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'sentAt': instance.sentAt.toIso8601String(),
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
    };
