import 'package:bookly_app/controller/services/_core.dart';
import 'package:bookly_app/helpers/http_client.dart';
import 'package:bookly_app/helpers/networking.dart';
import 'package:bookly_app/helpers/paginated_data_model.dart';
import 'package:bookly_app/model/book_model/book_model.dart';

class SearchService {
  final ApiClient client;
  SearchService(this.client);
  Future<PaginatedData<BookModel>> getBooks({
    required String bookName,
    required String userId,
    int page = 1,
  }) async {
    final res = await client.get<ApiMap>(
      Endpoints.searchBooks
          .replaceAll('{bookName}', bookName)
          .replaceAll('{userId}', userId),
      query: {'pageNumber': page},
    );

    return PaginatedData.fromJson(
      res.data!,
      (json) => BookModel.fromJson(json as ApiMap),
      listKey: 'books',
    );
  }
}
