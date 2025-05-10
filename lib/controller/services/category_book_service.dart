import 'package:bookly_app/controller/services/_core.dart';
import 'package:bookly_app/helpers/http_client.dart';
import 'package:bookly_app/helpers/networking.dart';
import 'package:bookly_app/helpers/paginated_data_model.dart';
import 'package:bookly_app/model/book_model/book_model.dart';

class CategoryBookService {
  final ApiClient client;
  CategoryBookService(this.client);

  Future<PaginatedData<BookModel>> getCategoryBooks({
    required String categoryName,
    int page = 1,
  }) async {
    final endpoint =
        Endpoints.getCategoryBooks.replaceFirst('{categoryName}', categoryName);
    final res = await client.get<ApiMap>(
      endpoint,
      query: {'page': page},
    );
    return PaginatedData.fromJson(
      res.data!,
      (json) => BookModel.fromJson(json as ApiMap),
      listKey: 'books',
    );
  }
}
