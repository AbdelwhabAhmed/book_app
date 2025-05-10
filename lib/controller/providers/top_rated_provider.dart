import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/controller/services/top_rated_service.dart';
import 'package:bookly_app/model/book_model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopRatedState extends Equatable {
  final Exception? error;
  final bool isLoading;
  final List<BookModel> topRatedBooks;

  const TopRatedState({
    this.error,
    this.isLoading = false,
    this.topRatedBooks = const [],
  });

  TopRatedState copyWith({
    Exception? error,
    bool? isLoading,
    List<BookModel>? topRatedBooks,
  }) {
    return TopRatedState(
      error: error,
      isLoading: isLoading ?? this.isLoading,
      topRatedBooks: topRatedBooks ?? this.topRatedBooks,
    );
  }

  @override
  List<Object?> get props => [
        error,
        isLoading,
        topRatedBooks,
      ];
}

class TopRatedProvider extends StateNotifier<TopRatedState> {
  final TopRatedBooksService _topRatedBooksService;
  TopRatedProvider(this._topRatedBooksService) : super(const TopRatedState());

  Future<void> getTopRatedBooks() async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await _topRatedBooksService.getTopRatedBooks();

      state = state.copyWith(
        topRatedBooks: response,
        isLoading: false,
      );
    } on Exception catch (e) {
      state = state.copyWith(error: e, isLoading: false);
    }
  }
}

final getTopRatedBooksProvider =
    StateNotifierProvider<TopRatedProvider, TopRatedState>(
  (ref) {
    final topRatedBooksService = ref.read(topRatedBooksServiceProvider);
    return TopRatedProvider(topRatedBooksService);
  },
);
