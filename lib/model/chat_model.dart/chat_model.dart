import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel extends Equatable {
  final String userId;
  final String userName;
  final String profilePicture;
  final String lastMessage;
  final DateTime timeStamp;

  const ChatModel({
    required this.userId,
    required this.userName,
    required this.profilePicture,
    required this.lastMessage,
    required this.timeStamp,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  @override
  List<Object?> get props =>
      [userId, userName, profilePicture, lastMessage, timeStamp];
}
