import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/controller/services/categories_service.dart';
import 'package:bookly_app/helpers/scroll_helpers.dart';
import 'package:bookly_app/model/categories/category_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesState extends Equatable {
  final Exception? error;
  final bool isLoading;
  final List<CategoryModel> categories;
  final PaginationState paginationState;
  final int currentPage;
  final int totalPages;
  final int totalCount;

  const CategoriesState({
    this.error,
    this.isLoading = false,
    this.categories = const [],
    this.paginationState = PaginationState.loaded,
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalCount = 0,
  });

  CategoriesState copyWith({
    Exception? error,
    bool? isLoading,
    List<CategoryModel>? categories,
    PaginationState? paginationState,
    int? currentPage,
    int? totalPages,
    int? totalCount,
  }) {
    return CategoriesState(
      error: error,
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
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
        categories,
        paginationState,
        currentPage,
        totalPages,
        totalCount,
      ];
}

class CategoriesProvider extends StateNotifier<CategoriesState> {
  final CategoriesService _categoriesService;
  CategoriesProvider(this._categoriesService) : super(const CategoriesState());

  Future<void> getCategories({
    bool? reset = false,
  }) async {
    if (reset ?? false) {
      state = const CategoriesState();
    }

    state = state.copyWith(isLoading: true);

    try {
      final response = await _categoriesService.getCategories();

      state = state.copyWith(
        categories: response.data,
        isLoading: false,
        currentPage: response.pageNumber,
        totalPages: response.totalPages,
        totalCount: response.totalCount,
      );
    } on Exception catch (e) {
      state = state.copyWith(error: e, isLoading: false);
    }
  }

  Future<void> getMoreCategories({
    String? searchQuery,
    String? barcode,
  }) async {
    if (state.categories.isEmpty) return;
    if (state._isPaginating || !state.hasNextPage) return;

    state = state.copyWith(
      paginationState: PaginationState.paginating,
    );

    try {
      final response = await _categoriesService.getCategories(
        page: state.currentPage + 1,
      );

      state = state.copyWith(
        paginationState: PaginationState.loaded,
        categories: List.of(state.categories)..addAll(response.data),
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

  Future<void> selectCategories({
    required List<String> categoryIds,
    required String userId,
  }) async {
    await _categoriesService.selectCategories(
        categoryIds: categoryIds, userId: userId);
  }
}

final getCategoriesProvider =
    StateNotifierProvider<CategoriesProvider, CategoriesState>(
  (ref) {
    final categories = ref.read(categoriesServiceProvider);
    return CategoriesProvider(categories);
  },
);
