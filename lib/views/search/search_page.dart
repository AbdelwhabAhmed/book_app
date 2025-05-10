import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bookly_app/cach_data.dart';
import 'package:bookly_app/constants/app_colors.dart';
import 'package:bookly_app/controller/providers/search_provider.dart';
import 'package:bookly_app/helpers/scroll_helpers.dart';
import 'package:bookly_app/router/router.gr.dart';
import 'package:bookly_app/views/home/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late ScrollController _scrollController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(getSearchProvider.notifier).getBooks(
            bookName: _searchController.text,
            userId: '16d467fe-f875-4cb9-919b-07cca23bedf3',
          );
    });
    _scrollController = ScrollController()
      ..onScroll(() {
        try {
          ref.read(getSearchProvider.notifier).getMoreBooks(
                bookName: _searchController.text,
                userId: '16d467fe-f875-4cb9-919b-07cca23bedf3',
              );
        } on Exception catch (e) {
          if (mounted) {
            unawaited(showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ));
          }
        }
      });
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(getSearchProvider.notifier).getBooks(
            bookName: _searchController.text,
            userId: '16d467fe-f875-4cb9-919b-07cca23bedf3',
          );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final books = ref.watch(getSearchProvider);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBGC,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: context.router.maybePop,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search for books...',
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () => _searchController.clear(),
                                )
                              : null,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        onChanged: (value) {
                          _onSearchChanged();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (books.isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (books.books.isEmpty)
              const Center(
                child: Text('No books found'),
              )
            else
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: books.books.length,
                  itemBuilder: (context, index) {
                    final book = books.books[index];
                    return BookCard(
                      book: book,
                      onTap: () {
                        context.router.push(BookDetailsRoute(
                          book: book,
                        ));
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
