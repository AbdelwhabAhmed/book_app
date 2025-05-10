import 'package:bookly_app/controller/services/_core.dart';
import 'package:bookly_app/helpers/http_client.dart';
import 'package:bookly_app/helpers/networking.dart';
import 'package:bookly_app/helpers/paginated_data_model.dart';
import 'package:bookly_app/model/categories/category_model.dart';

class CategoriesService {
  final ApiClient client;
  CategoriesService(this.client);

  Future<PaginatedData<CategoryModel>> getCategories({
    int page = 1,
  }) async {
    final res = await client.get<ApiMap>(
      Endpoints.getCategories,
      query: {'page': page},
    );
    return PaginatedData.fromJson(
      res.data!,
      (json) => CategoryModel.fromJson(json as ApiMap),
      listKey: 'categories',
    );
  }

  Future<void> selectCategories({
    required List<String> categoryIds,
    required String userId,
  }) async {
    await client.post(
      Endpoints.selectCategories,
      body: {'categoryIds': categoryIds, 'userId': userId},
    );
  }
}
