import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/controller/services/book_service.dart';
import 'package:bookly_app/controller/services/top_rated_service.dart';
import 'package:bookly_app/model/book_model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopBooksState extends Equatable {
  final Exception? error;
  final bool isLoading;
  final List<BookModel> topBooks;

  const TopBooksState({
    this.error,
    this.isLoading = false,
    this.topBooks = const [],
  });

  TopBooksState copyWith({
    Exception? error,
    bool? isLoading,
    List<BookModel>? topBooks,
  }) {
    return TopBooksState(
      error: error,
      isLoading: isLoading ?? this.isLoading,
      topBooks: topBooks ?? this.topBooks,
    );
  }

  @override
  List<Object?> get props => [
        error,
        isLoading,
        topBooks,
      ];
}

class TopBooksProvider extends StateNotifier<TopBooksState> {
  final BookService _bookService;
  TopBooksProvider(this._bookService) : super(const TopBooksState());

  Future<void> getTopBooksByUserCategories({
    required String userId,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await _bookService.getTopBooksByUserCategories(
        userId: userId,
      );

      state = state.copyWith(
        topBooks: response,
        isLoading: false,
      );
    } on Exception catch (e) {
      state = state.copyWith(error: e, isLoading: false);
    }
  }
}

final getTopBooksByUserCategoriesProvider =
    StateNotifierProvider<TopBooksProvider, TopBooksState>(
  (ref) {
    final bookService = ref.read(bookServiceProvider);
    return TopBooksProvider(bookService);
  },
);
