import 'package:bookly_app/controller/services/_core.dart';
import 'package:bookly_app/helpers/http_client.dart';
import 'package:bookly_app/model/book_model/book_model.dart';

class RecommendService {
  final ApiClient client;
  RecommendService(this.client);

  Future<List<BookModel>> getRecommendations({
    required String userId,
  }) async {
    final endpoint =
        'https://6881-196-137-109-96.ngrok-free.app/generate_recommendations/';
    final res = await client.get<ApiMap>(
      endpoint,
      query: {'user_id': userId},
    );

    final List<dynamic> booksJson =
        res.data!["recommended_books"] as List<dynamic>;
    return booksJson.map((json) => BookModel.fromJson(json as ApiMap)).toList();
  }
}
