import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recived_model.g.dart';

@JsonSerializable()
class RecievedMessages extends Equatable {
  final int id;
  final String content;
  final DateTime sentAt;
  final String senderId;
  final String receiverId;

  const RecievedMessages({
    required this.id,
    required this.content,
    required this.sentAt,
    required this.senderId,
    required this.receiverId,
  });

  factory RecievedMessages.fromJson(Map<String, dynamic> json) =>
      _$RecievedMessagesFromJson(json);

  Map<String, dynamic> toJson() => _$RecievedMessagesToJson(this);

  @override
  List<Object?> get props => [id, content, sentAt, senderId, receiverId];
}
