import 'package:bookly_app/controller/services/_core.dart';
import 'package:bookly_app/helpers/http_client.dart';
import 'package:bookly_app/helpers/networking.dart';
import 'package:bookly_app/model/chat_model.dart/chat_model.dart';

class ChatService {
  final ApiClient client;
  ChatService(this.client);

  Future<List<ChatModel>> getChats({
    required String userId,
  }) async {
    final res = await client.get<ApiMap>(
      Endpoints.getChat,
      query: {'userId': userId},
    );

    final List<dynamic> chatsJson = res.data as List<dynamic>;
    return chatsJson.map((json) => ChatModel.fromJson(json as ApiMap)).toList();
  }
}
