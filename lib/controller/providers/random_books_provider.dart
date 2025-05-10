import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/controller/services/random_books_service.dart';
import 'package:bookly_app/model/book_model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookState extends Equatable {
  final Exception? error;
  final bool isLoading;
  final List<BookModel> randomBooks;

  const BookState({
    this.error,
    this.isLoading = false,
    this.randomBooks = const [],
  });

  BookState copyWith({
    Exception? error,
    bool? isLoading,
    List<BookModel>? randomBooks,
  }) {
    return BookState(
      error: error,
      isLoading: isLoading ?? this.isLoading,
      randomBooks: randomBooks ?? this.randomBooks,
    );
  }

  @override
  List<Object?> get props => [
        error,
        isLoading,
        randomBooks,
      ];
}

class BookProvider extends StateNotifier<BookState> {
  final RandomBooksService _randomBooksService;
  BookProvider(this._randomBooksService) : super(const BookState());

  Future<void> getRandomBooks() async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await _randomBooksService.getRandomBooks();

      state = state.copyWith(
        randomBooks: response,
        isLoading: false,
      );
    } on Exception catch (e) {
      state = state.copyWith(error: e, isLoading: false);
    }
  }
}

final getRandomBooksProvider = StateNotifierProvider<BookProvider, BookState>(
  (ref) {
    final randomBooksService = ref.read(randomBooksServiceProvider);
    return BookProvider(randomBooksService);
  },
);
