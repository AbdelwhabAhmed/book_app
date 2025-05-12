import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/controller/services/chat_service.dart';
import 'package:bookly_app/model/chat_model.dart/chat_model.dart';
import 'package:bookly_app/model/recived_messages/recived_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatState extends Equatable {
  final Exception? error;
  final bool isLoading;
  final List<ChatModel> chats;
  // final List<RecievedMessages> recievedMessages;

  const ChatState({
    this.error,
    this.isLoading = false,
    this.chats = const [],
    // this.recievedMessages = const [],
  });

  ChatState copyWith({
    Exception? error,
    bool? isLoading,
    List<ChatModel>? chats,
    // List<RecievedMessages>? recievedMessages,
  }) {
    return ChatState(
      error: error,
      isLoading: isLoading ?? this.isLoading,
      chats: chats ?? this.chats,
      // recievedMessages: recievedMessages ?? this.recievedMessages,
    );
  }

  @override
  List<Object?> get props => [
        error,
        isLoading,
        chats,
      ];
}

class ChatProvider extends StateNotifier<ChatState> {
  final ChatService _chatService;
  ChatProvider(this._chatService) : super(const ChatState());

  // Future<void> getChats({
  //   required String userId,
  // }) async {
  //   state = state.copyWith(isLoading: true);

  //   try {
  //     final response = await _chatService.getChats(
  //       userId: userId,
  //     );

  //     state = state.copyWith(
  //       recievedMessages: response,
  //       isLoading: false,
  //     );
  //   } on Exception catch (e) {
  //     state = state.copyWith(error: e, isLoading: false);
  //   }
  // }

  Future<void> sendMessage({
    required String userId,
    required String message,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      await _chatService.sendMessage(userId: userId, message: message);
    } on Exception catch (e) {
      state = state.copyWith(error: e, isLoading: false);
    }
  }
}

final getChatsProvider = StateNotifierProvider<ChatProvider, ChatState>(
  (ref) {
    final chatService = ref.read(chatServiceProvider);
    return ChatProvider(chatService);
  },
);
