import 'dart:async';
import 'dart:convert';
import 'package:bookly_app/helpers/http_client.dart';
import 'package:bookly_app/helpers/networking.dart';
import 'package:bookly_app/model/book_model/book_model.dart';

class AddBookService {
  final ApiClient client;
  BookModel? book;
  AddBookService(this.client);

  // {
  // "Name": "Book Title",
  // "Author": "Author Name",
  // "Description": "Brief description of the book",
  // "FileURL": "https://example.com/ebook.pdf",
  // "PublishedYear": 2020,
  // "AverageRating": 4.8,
  // "NumPages": 300,
  // "LinkBook": "https://linktobook.com"
  // }
  Future<BookModel?> addBook(
    String userId,
    String categoryId,
    String name,
    String author,
    String description,
    String fileUrl,
    int? publishedYear,
    double? averageRating,
    int? numPages,
    String? linkBook,
  ) async {
    final response = await client.post(
      Endpoints.addBook
          .replaceAll('{userId}', userId)
          .replaceAll('{categoryId}', categoryId),
      body: {
        'Name': name,
        'Author': author,
        'Description': description,
        'FileURL': fileUrl,
        'PublishedYear': publishedYear,
        'AverageRating': averageRating,
        'NumPages': numPages,
        'LinkBook': linkBook ?? '',
      },
    );

    dynamic data;
    if (response.data is String) {
      try {
        data = jsonDecode(response.data);
      } catch (_) {
        data = {'message': response.data};
      }
    } else {
      data = response.data;
    }

    // If your backend returns only a message, you may want to return null or handle accordingly
    if (data is Map<String, dynamic> && data.containsKey('Name')) {
      return BookModel.fromJson(data);
    } else {
      // Optionally handle the message
      return null;
    }
  }
}
