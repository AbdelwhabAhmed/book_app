import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/controller/services/history_service.dart';
import 'package:bookly_app/helpers/scroll_helpers.dart';
import 'package:bookly_app/model/book_model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryState extends Equatable {
  final Exception? error;
  final bool isLoading;
  final List<BookModel> historyBooks;
  final PaginationState paginationState;
  final int currentPage;
  final int totalPages;
  final int totalCount;

  const HistoryState({
    this.error,
    this.isLoading = false,
    this.historyBooks = const [],
    this.paginationState = PaginationState.loaded,
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalCount = 0,
  });

  HistoryState copyWith({
    Exception? error,
    bool? isLoading,
    List<BookModel>? historyBooks,
    PaginationState? paginationState,
    int? currentPage,
    int? totalPages,
    int? totalCount,
  }) {
    return HistoryState(
      error: error,
      isLoading: isLoading ?? this.isLoading,
      historyBooks: historyBooks ?? this.historyBooks,
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
        historyBooks,
        paginationState,
        currentPage,
        totalPages,
        totalCount,
      ];
}

class HistoryProvider extends StateNotifier<HistoryState> {
  final HistoryService _historyService;
  HistoryProvider(this._historyService) : super(const HistoryState());

  Future<void> getHistory({
    required String userId,
    bool? reset = false,
  }) async {
    if (reset ?? false) {
      state = const HistoryState();
    }
    state = state.copyWith(isLoading: true);
    try {
      final response = await _historyService.getHistory(
        userId: userId,
        page: state.currentPage,
      );
      state = state.copyWith(
        historyBooks: response.data,
        isLoading: false,
        currentPage: response.pageNumber,
        totalPages: response.totalPages,
        totalCount: response.totalCount,
      );
    } on Exception catch (e) {
      state = state.copyWith(error: e, isLoading: false);
    }
  }

  Future<void> getMoreHistory({
    required String userId,
  }) async {
    if (state.historyBooks.isEmpty) return;
    if (state._isPaginating || !state.hasNextPage) return;
    state = state.copyWith(paginationState: PaginationState.paginating);
    try {
      final response = await _historyService.getHistory(
        userId: userId,
        page: state.currentPage + 1,
      );
      state = state.copyWith(
        paginationState: PaginationState.loaded,
        historyBooks: List.of(state.historyBooks)..addAll(response.data),
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

final getHistoryProvider = StateNotifierProvider<HistoryProvider, HistoryState>(
  (ref) {
    final history = ref.read(historyServiceProvider);
    return HistoryProvider(history);
  },
);
