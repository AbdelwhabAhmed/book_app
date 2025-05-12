import 'package:bookly_app/env.dart';
import 'package:dio/dio.dart';

Dio get dioInstance {
  final dio = Dio(
    BaseOptions(
      baseUrl: kBaseUrl,
      contentType: 'application/json',
      headers: {
        'Accept': 'application/json',
      },
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        // final globalContext = NavigationContext.context;
        // if (globalContext != null) {
        //   final lang = globalContext.locale.languageCode;
        //   options.headers['Accept-Language'] = lang;
        // }
        handler.next(options);
      },
    ),
  );

  return dio;
}

class Endpoints {
  Endpoints._();
  static const String register = 'user/Register';
  static const String login = 'user/Login';
  static const String getUser = 'user/{userId}';
  static const String getBooks = 'Book/GetAll/{userId}';
  static const String searchBooks = 'Book/BookName/{bookName}/{userId}';
  static const String getRandomBooks = 'Book/GetRandomBooks/{userId}';
  static const String getCategories = 'Category?pageSize=15';
  static const String getTopRatedBooks = 'Book/GetTopRatedBooks/{userId}';
  static const String getCategoryBooks =
      'Book/CategoryName/{categoryName}/{userId}';
  static const String getFavorites = 'favourite/favorites/{userId}';
  static const String toggleFavorite = 'favourite/toggle-favorite';
  static const String selectCategories = 'UserCategory/select-categories';
  static const String addReview = 'Reviews';
  static const String getHistory = 'History/{userId}';
  static const String addHistory = 'History/add';
  static const String getChat = 'message/api';
  static const String sendMessage = 'Message/send-message-to-admin';
  static const String addBook = 'Book/Create/{userId}/{categoryId}';
}
