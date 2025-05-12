import 'dart:async';

import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/controller/services/add_book_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBookState extends Equatable {
  final Exception? error;
  final String? message;
  final bool isLoading;

  const AddBookState({
    this.error,
    this.message,
    this.isLoading = false,
  });

  AddBookState copyWith({
    bool? isLoading,
    Exception? error,
    String? message,
  }) {
    return AddBookState(
      error: error,
      message: message,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [message, isLoading, error];
}

class AddBookProvider extends StateNotifier<AddBookState> {
  final AddBookService _addBookService;
  final SharedPreferences prefs;
  AddBookProvider(this._addBookService, this.prefs)
      : super(const AddBookState());

  Future<void> addBook(
      String userId,
      String categoryId,
      String name,
      String author,
      String description,
      String fileUrl,
      int? publishedYear,
      double? averageRating,
      int? numPages,
      String? linkBook) async {
    state = state.copyWith(isLoading: true);
    try {
      await _addBookService.addBook(
        userId,
        categoryId,
        name,
        author,
        description,
        fileUrl,
        publishedYear,
        averageRating,
        numPages,
        linkBook,
      );
      state =
          state.copyWith(isLoading: false, message: 'Book added successfully');
    } on Exception catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }
}

final addBookProvider =
    StateNotifierProvider.autoDispose<AddBookProvider, AddBookState>((ref) {
  final addBookService = ref.read(addBookServiceProvider);
  final prefs = ref.read(prefsProvider);
  return AddBookProvider(addBookService, prefs);
});
