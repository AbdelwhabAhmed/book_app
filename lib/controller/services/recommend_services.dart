import 'package:bookly_app/controller/services/_core.dart';
import 'package:bookly_app/helpers/http_client.dart';
import 'package:bookly_app/model/book_model/book_model.dart';

class RecommendService {
  final ApiClient client;
  RecommendService(this.client);

  Future<List<BookModel>> getRecommendationsByBookId({
    required String bookId,
    required String userId,
  }) async {
    final res = await client.get<Map<String, dynamic>>(
      'https://d0cf-196-154-43-137.ngrok-free.app/recommend_by_book_id/',
      query: {'user_id': userId, 'book_id': bookId},
    );
    final booksJson = res.data?['recommended_books'] as List<dynamic>? ?? [];
    return booksJson
        .map((json) => BookModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<BookModel>> getRecommendations({
    required String userId,
  }) async {
    final endpoint =
        'https://d0cf-196-154-43-137.ngrok-free.app/generate_recommendations/';
    final res = await client.get<ApiMap>(
      endpoint,
      query: {'user_id': userId},
    );

    final List<dynamic> booksJson =
        res.data!["recommended_books"] as List<dynamic>;
    return booksJson.map((json) => BookModel.fromJson(json as ApiMap)).toList();
  }
}
