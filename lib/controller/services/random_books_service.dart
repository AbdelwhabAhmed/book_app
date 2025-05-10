import 'package:bookly_app/helpers/http_client.dart';
import 'package:bookly_app/helpers/networking.dart';
import 'package:bookly_app/model/book_model/book_model.dart';

class RandomBooksService {
  final ApiClient client;
  RandomBooksService(this.client);

  Future<List<BookModel>> getRandomBooks() async {
    final res = await client.get<List<dynamic>>(
      Endpoints.getRandomBooks,
    );
    final books = res.data ?? [];
    return books
        .map((json) => BookModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
