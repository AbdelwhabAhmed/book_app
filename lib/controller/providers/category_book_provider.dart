import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/controller/services/category_book_service.dart';
import 'package:bookly_app/helpers/scroll_helpers.dart';
import 'package:bookly_app/model/book_model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryBookState extends Equatable {
  final Exception? error;
  final bool isLoading;
  final List<BookModel> books;
  final PaginationState paginationState;
  final int currentPage;
  final int totalPages;
  final int totalCount;

  const CategoryBookState({
    this.error,
    this.isLoading = false,
    this.books = const [],
    this.paginationState = PaginationState.loaded,
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalCount = 0,
  });

  CategoryBookState copyWith({
    Exception? error,
    bool? isLoading,
    List<BookModel>? books,
    PaginationState? paginationState,
    int? currentPage,
    int? totalPages,
    int? totalCount,
  }) {
    return CategoryBookState(
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

class CategoryBookProvider extends StateNotifier<CategoryBookState> {
  final CategoryBookService _categoryBookService;
  CategoryBookProvider(this._categoryBookService)
      : super(const CategoryBookState());

  Future<void> getBooks({
    required String categoryName,
    bool? reset = false,
  }) async {
    if (reset ?? false) {
      state = const CategoryBookState();
    }

    state = state.copyWith(isLoading: true);

    try {
      final response = await _categoryBookService.getCategoryBooks(
        categoryName: categoryName,
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
    required String categoryName,
  }) async {
    if (state.books.isEmpty) return;
    if (state._isPaginating || !state.hasNextPage) return;

    state = state.copyWith(
      paginationState: PaginationState.paginating,
    );

    try {
      final response = await _categoryBookService.getCategoryBooks(
        categoryName: categoryName,
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

final getCategoryBooksProvider =
    StateNotifierProvider<CategoryBookProvider, CategoryBookState>(
  (ref) {
    final categoryBook = ref.read(categoryBookServiceProvider);
    return CategoryBookProvider(categoryBook);
  },
);
