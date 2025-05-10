import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/controller/services/recommend_services.dart';
import 'package:bookly_app/model/book_model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecommendedBookState extends Equatable {
  final Exception? error;
  final bool isLoading;
  final List<BookModel> recommendedBooks;

  const RecommendedBookState({
    this.error,
    this.isLoading = false,
    this.recommendedBooks = const [],
  });

  RecommendedBookState copyWith({
    Exception? error,
    bool? isLoading,
    List<BookModel>? recommendedBooks,
  }) {
    return RecommendedBookState(
      error: error,
      isLoading: isLoading ?? this.isLoading,
      recommendedBooks: recommendedBooks ?? this.recommendedBooks,
    );
  }

  @override
  List<Object?> get props => [
        error,
        isLoading,
        recommendedBooks,
      ];
}

class RecommendedBookProvider extends StateNotifier<RecommendedBookState> {
  final RecommendService _recommendService;
  RecommendedBookProvider(this._recommendService)
      : super(const RecommendedBookState());

  Future<void> getRecommendedBooks({
    required String userId,
    bool? reset = false,
  }) async {
    if (reset ?? false) {
      state = const RecommendedBookState();
    }
    state = state.copyWith(isLoading: true);
    try {
      final response = await _recommendService.getRecommendations(
        userId: userId,
      );
      state = state.copyWith(
        recommendedBooks: response,
        isLoading: false,
      );
    } on Exception catch (e) {
      state = state.copyWith(error: e, isLoading: false);
    }
  }
}

final getRecommendedBooksProvider =
    StateNotifierProvider<RecommendedBookProvider, RecommendedBookState>(
  (ref) {
    final books = ref.read(recommendServiceProvider);
    return RecommendedBookProvider(books);
  },
);
