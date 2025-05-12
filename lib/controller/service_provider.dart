import 'package:bookly_app/controller/services/add_book_service.dart';
import 'package:bookly_app/controller/services/auth_service.dart';
import 'package:bookly_app/controller/services/book_service.dart';
import 'package:bookly_app/controller/services/categories_service.dart';
import 'package:bookly_app/controller/services/category_book_service.dart';
import 'package:bookly_app/controller/services/chat_service.dart';
import 'package:bookly_app/controller/services/history_service.dart';
import 'package:bookly_app/controller/services/random_books_service.dart';
import 'package:bookly_app/controller/services/recommend_services.dart';
import 'package:bookly_app/controller/services/saerch_service.dart';
import 'package:bookly_app/controller/services/top_rated_service.dart';
import 'package:bookly_app/helpers/http_client.dart';
import 'package:bookly_app/helpers/networking.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dioProvider = Provider((ref) => dioInstance);

final httpClient = Provider<ApiClient>(
  (ref) => ApiClient(
    dioInstance,
  ),
);

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

final prefsProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

final bookServiceProvider = Provider<BookService>(
  (ref) => BookService(ref.read(httpClient)),
);

final randomBooksServiceProvider = Provider<RandomBooksService>(
  (ref) => RandomBooksService(ref.read(httpClient)),
);

final categoriesServiceProvider = Provider<CategoriesService>(
  (ref) => CategoriesService(ref.read(httpClient)),
);

final topRatedBooksServiceProvider = Provider<TopRatedBooksService>(
  (ref) => TopRatedBooksService(ref.read(httpClient)),
);

final categoryBookServiceProvider = Provider<CategoryBookService>(
  (ref) => CategoryBookService(ref.read(httpClient)),
);

final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(ref.read(httpClient)),
);

final historyServiceProvider = Provider<HistoryService>(
  (ref) => HistoryService(ref.read(httpClient)),
);

final recommendServiceProvider = Provider<RecommendService>(
  (ref) => RecommendService(ref.read(httpClient)),
);

final searchServiceProvider = Provider<SearchService>(
  (ref) => SearchService(ref.read(httpClient)),
);

final chatServiceProvider = Provider<ChatService>(
  (ref) => ChatService(ref.read(httpClient)),
);

final addBookServiceProvider = Provider<AddBookService>(
  (ref) => AddBookService(ref.read(httpClient)),
);
