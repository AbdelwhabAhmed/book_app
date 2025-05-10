import 'package:bookly_app/controller/services/_core.dart';
import 'package:bookly_app/helpers/http_client.dart';
import 'package:bookly_app/helpers/networking.dart';
import 'package:bookly_app/model/book_model/book_model.dart';
import 'package:bookly_app/helpers/paginated_data_model.dart';

class HistoryService {
  final ApiClient client;
  HistoryService(this.client);

  Future<void> addHistory(String userId, String bookId) async {
    await client.post(
      Endpoints.addHistory,
      body: {'userId': userId, 'bookId': bookId},
    );
  }

  Future<PaginatedData<BookModel>> getHistory({
    required String userId,
    int page = 1,
  }) async {
    final endpoint = Endpoints.getHistory.replaceAll('{userId}', userId);
    final res = await client.get<ApiMap>(
      endpoint,
      query: {'page': page},
    );

    return PaginatedData.fromJson(
      res.data!,
      (json) => BookModel.fromJson(json as ApiMap),
      listKey: 'history',
    );
  }
}
