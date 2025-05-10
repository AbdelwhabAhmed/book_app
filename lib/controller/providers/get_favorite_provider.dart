import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/controller/services/book_service.dart';
import 'package:bookly_app/helpers/scroll_helpers.dart';
import 'package:bookly_app/model/book_model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteBookState extends Equatable {
  final Exception? error;
  final bool isLoading;
  final List<BookModel> favoriteBooks;
  final PaginationState paginationState;
  final int currentPage;
  final int totalPages;
  final int totalCount;

  const FavoriteBookState({
    this.error,
    this.isLoading = false,
    this.favoriteBooks = const [],
    this.paginationState = PaginationState.loaded,
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalCount = 0,
  });

  FavoriteBookState copyWith({
    Exception? error,
    bool? isLoading,
    List<BookModel>? favoriteBooks,
    PaginationState? paginationState,
    int? currentPage,
    int? totalPages,
    int? totalCount,
  }) {
    return FavoriteBookState(
      error: error,
      isLoading: isLoading ?? this.isLoading,
      favoriteBooks: favoriteBooks ?? this.favoriteBooks,
      paginationState: paginationState ?? this.paginationState,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  bool get hasNextPage => currentPage < totalPages;
  bool get _isPaginating => paginationState == PaginationState.paginating;

  @override
  List<Object?> get props => [
        error,
        isLoading,
        favoriteBooks,
        paginationState,
        currentPage,
        totalPages,
        totalCount,
      ];
}

class FavoriteBookProvider extends StateNotifier<FavoriteBookState> {
  final BookService _bookService;
  FavoriteBookProvider(this._bookService) : super(const FavoriteBookState());

  Future<void> getFavorites({
    required String userId,
    bool? reset = false,
  }) async {
    if (reset ?? false) {
      state = const FavoriteBookState();
    }
    state = state.copyWith(isLoading: true);
    try {
      final response = await _bookService.getFavorites(
        page: state.currentPage,
        userId: userId,
      );
      state = state.copyWith(
        favoriteBooks: response.data,
        isLoading: false,
        currentPage: response.pageNumber,
        totalPages: response.totalPages,
        totalCount: response.totalCount,
      );
    } on Exception catch (e) {
      state = state.copyWith(error: e, isLoading: false);
    }
  }

  Future<void> getMoreFavorites({
    required String userId,
  }) async {
    if (state.favoriteBooks.isEmpty) return;
    if (state._isPaginating || !state.hasNextPage) return;
    state = state.copyWith(paginationState: PaginationState.paginating);
    try {
      final response = await _bookService.getFavorites(
        page: state.currentPage + 1,
        userId: userId,
      );
      state = state.copyWith(
        paginationState: PaginationState.loaded,
        favoriteBooks: List.of(state.favoriteBooks)..addAll(response.data),
        currentPage: response.pageNumber,
        totalPages: response.totalPages,
        totalCount: response.totalCount,
      );
    } on Exception catch (e) {
      state = state.copyWith(
        error: e,
        paginationState: PaginationState.loaded,
      );
    }
  }
}

final getFavoriteBooksProvider =
    StateNotifierProvider<FavoriteBookProvider, FavoriteBookState>(
  (ref) {
    final books = ref.read(bookServiceProvider);
    return FavoriteBookProvider(books);
  },
);
