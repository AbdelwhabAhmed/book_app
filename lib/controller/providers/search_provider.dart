import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/controller/services/saerch_service.dart';
import 'package:bookly_app/helpers/scroll_helpers.dart';
import 'package:bookly_app/model/book_model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchState extends Equatable {
  final Exception? error;
  final bool isLoading;
  final List<BookModel> books;
  final PaginationState paginationState;
  final int currentPage;
  final int totalPages;
  final int totalCount;

  const SearchState({
    this.error,
    this.isLoading = false,
    this.books = const [],
    this.paginationState = PaginationState.loaded,
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalCount = 0,
  });

  SearchState copyWith({
    Exception? error,
    bool? isLoading,
    List<BookModel>? books,
    PaginationState? paginationState,
    int? currentPage,
    int? totalPages,
    int? totalCount,
  }) {
    return SearchState(
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

class SearchProvider extends StateNotifier<SearchState> {
  final SearchService _searchService;
  SearchProvider(this._searchService) : super(const SearchState());

  Future<void> getBooks({
    String? bookName,
    String? userId,
    bool? reset = false,
  }) async {
    if (reset ?? false) {
      state = const SearchState();
    }

    state = state.copyWith(isLoading: true);

    try {
      final response = await _searchService.getBooks(
        bookName: bookName ?? '',
        userId: userId ?? '',
      );

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
    String? bookName,
    String? userId,
  }) async {
    if (state.books.isEmpty) return;
    if (state._isPaginating || !state.hasNextPage) return;

    state = state.copyWith(
      paginationState: PaginationState.paginating,
    );

    try {
      final response = await _searchService.getBooks(
        bookName: bookName ?? '',
        userId: userId ?? '',
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
}

final getSearchProvider = StateNotifierProvider<SearchProvider, SearchState>(
  (ref) {
    final books = ref.read(searchServiceProvider);
    return SearchProvider(books);
  },
);
