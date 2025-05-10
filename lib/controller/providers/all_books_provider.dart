import 'package:bookly_app/controller/providers/get_favorite_provider.dart';
import 'package:bookly_app/controller/providers/history_provider.dart';
import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/controller/services/book_service.dart';
import 'package:bookly_app/controller/services/history_service.dart';
import 'package:bookly_app/helpers/scroll_helpers.dart';
import 'package:bookly_app/model/book_model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookState extends Equatable {
  final Exception? error;
  final bool isLoading;
  final List<BookModel> books;
  final PaginationState paginationState;
  final int currentPage;
  final int totalPages;
  final int totalCount;

  const BookState({
    this.error,
    this.isLoading = false,
    this.books = const [],
    this.paginationState = PaginationState.loaded,
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalCount = 0,
  });

  BookState copyWith({
    Exception? error,
    bool? isLoading,
    List<BookModel>? books,
    PaginationState? paginationState,
    int? currentPage,
    int? totalPages,
    int? totalCount,
  }) {
    return BookState(
      error: error,
      isLoading: isLoading ?? this.isLoading,
      books: books ?? this.books,
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
        books,
        paginationState,
        currentPage,
        totalPages,
        totalCount,
      ];
}

class BookProvider extends StateNotifier<BookState> {
  final BookService _bookService;
  final HistoryService historyService;
  final FavoriteBookProvider favoriteBookProvider;

  BookProvider(
      this._bookService, this.favoriteBookProvider, this.historyService)
      : super(const BookState());

  Future<void> getBooks({
    String? searchQuery,
    String? barcode,
    bool? reset = false,
  }) async {
    if (reset ?? false) {
      state = const BookState();
    }

    state = state.copyWith(isLoading: true);

    try {
      final response = await _bookService.getBooks();

      state = state.copyWith(
        books: response.data,
        isLoading: false,
        currentPage: response.pageNumber,
        totalPages: response.totalPages,
        totalCount: response.totalCount,
      );
    } on Exception catch (e) {
      state = state.copyWith(error: e, isLoading: false);
    }
  }

  Future<void> getMoreBooks({
    String? searchQuery,
    String? barcode,
  }) async {
    if (state.books.isEmpty) return;
    if (state._isPaginating || !state.hasNextPage) return;

    state = state.copyWith(
      paginationState: PaginationState.paginating,
    );

    try {
      final response = await _bookService.getBooks(
        page: state.currentPage + 1,
      );

      state = state.copyWith(
        paginationState: PaginationState.loaded,
        books: List.of(state.books)..addAll(response.data),
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

  Future<void> toggleFavorite(String bookId, String userId) async {
    try {
      await _bookService.toggleFavorite(userId, bookId);
      await favoriteBookProvider.getFavorites(userId: userId);
    } on Exception catch (e) {
      state = state.copyWith(error: e);
    }
  }

  Future<void> addReview(String bookId, String userId, int rating) async {
    await _bookService.addReview(bookId, userId, rating);
  }

  Future<void> addHistory(String userId, String bookId) async {
    try {
      await historyService.addHistory(userId, bookId);
      state = state.copyWith(isLoading: false);
    } on Exception catch (e) {
      state = state.copyWith(error: e);
    }
  }
}

final getBooksProvider = StateNotifierProvider<BookProvider, BookState>(
  (ref) {
    final books = ref.read(bookServiceProvider);
    final favoriteBooks = ref.read(getFavoriteBooksProvider.notifier);
    final history = ref.read(historyServiceProvider);
    return BookProvider(books, favoriteBooks, history);
  },
);
