import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/controller/services/recommend_services.dart';
import 'package:bookly_app/model/book_model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimilarBooksState extends Equatable {
  final Exception? error;
  final bool isLoading;
  final List<BookModel> similarBooks;

  const SimilarBooksState({
    this.error,
    this.isLoading = false,
    this.similarBooks = const [],
  });

  SimilarBooksState copyWith({
    Exception? error,
    bool? isLoading,
    List<BookModel>? similarBooks,
  }) {
    return SimilarBooksState(
      error: error,
      isLoading: isLoading ?? this.isLoading,
      similarBooks: similarBooks ?? this.similarBooks,
    );
  }

  @override
  List<Object?> get props => [
        error,
        isLoading,
        similarBooks,
      ];
}

class SimilarBooksProvider extends StateNotifier<SimilarBooksState> {
  final RecommendService _recommendService;
  SimilarBooksProvider(this._recommendService)
      : super(const SimilarBooksState());

  Future<void> getSimilarBooks({
    required String userId,
    required String bookId,
    bool? reset = false,
  }) async {
    if (reset ?? false) {
      state = const SimilarBooksState();
    }
    state = state.copyWith(isLoading: true);
    try {
      final response = await _recommendService.getRecommendationsByBookId(
        userId: userId,
        bookId: bookId,
      );
      state = state.copyWith(
        similarBooks: response,
        isLoading: false,
      );
    } on Exception catch (e) {
      state = state.copyWith(error: e, isLoading: false);
    }
  }
}

final getSimilarBooksProvider =
    StateNotifierProvider<SimilarBooksProvider, SimilarBooksState>(
  (ref) {
    final books = ref.read(recommendServiceProvider);
    return SimilarBooksProvider(books);
  },
);
