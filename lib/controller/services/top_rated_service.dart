import 'package:bookly_app/helpers/http_client.dart';
import 'package:bookly_app/helpers/networking.dart';
import 'package:bookly_app/model/book_model/book_model.dart';

class TopRatedBooksService {
  final ApiClient client;
  TopRatedBooksService(this.client);

  Future<List<BookModel>> getTopRatedBooks() async {
    final res = await client.get<List<dynamic>>(
      Endpoints.getTopRatedBooks,
    );
    final books = res.data ?? [];
    return books
        .map((json) => BookModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
