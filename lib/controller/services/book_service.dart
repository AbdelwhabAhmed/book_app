import 'package:bookly_app/controller/services/_core.dart';
import 'package:bookly_app/helpers/http_client.dart';
import 'package:bookly_app/helpers/networking.dart';
import 'package:bookly_app/model/book_model/book_model.dart';
import 'package:bookly_app/helpers/paginated_data_model.dart';

class BookService {
  final ApiClient client;
  BookService(this.client);

  Future<PaginatedData<BookModel>> getBooks({
    int page = 1,
  }) async {
    final res = await client.get<ApiMap>(
      Endpoints.getBooks,
      query: {'pageNumber': page},
    );

    return PaginatedData.fromJson(
      res.data!,
      (json) => BookModel.fromJson(json as ApiMap),
      listKey: 'books',
    );
  }

  Future<void> toggleFavorite(String userId, String bookId) async {
    await client.post(
      Endpoints.toggleFavorite,
      body: {'userId': userId, 'bookId': bookId},
    );
  }

  Future<void> addReview(
    String bookId,
    String userId,
    int rating,
  ) async {
    await client.post(
      Endpoints.addReview,
      body: {
        'bookId': bookId,
        'userId': userId,
      },
    );
  }

  Future<PaginatedData<BookModel>> getFavorites({
    required String userId,
    int page = 1,
  }) async {
    final res = await client.get<ApiMap>(
      Endpoints.getFavorites.replaceAll('{userId}', userId),
      query: {'pageNumber': page},
    );

    return PaginatedData.fromJson(
      res.data!,
      (json) => BookModel.fromJson(json as ApiMap),
      listKey: 'books',
    );
  }

  Future<List<BookModel>> getTopBooksByUserCategories({
    required String userId,
  }) async {
    final res = await client.get<List<dynamic>>(
      Endpoints.getTopBooksByUserCategories.replaceAll('{userId}', userId),
    );
    final books = res.data ?? [];
    return books
        .map((json) => BookModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
