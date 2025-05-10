import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bookly_app/constants/app_colors.dart';
import 'package:bookly_app/controller/providers/category_book_provider.dart';
import 'package:bookly_app/helpers/context_extension.dart';
import 'package:bookly_app/helpers/scroll_helpers.dart';
import 'package:bookly_app/router/router.gr.dart';
import 'package:bookly_app/views/home/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class CategoryBooksPage extends ConsumerStatefulWidget {
  final String categoryName;
  const CategoryBooksPage({
    super.key,
    required this.categoryName,
  });

  @override
  ConsumerState<CategoryBooksPage> createState() => _CategoryBooksPageState();
}

class _CategoryBooksPageState extends ConsumerState<CategoryBooksPage> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(getCategoryBooksProvider.notifier).getBooks(
            categoryName: widget.categoryName,
          );
    });
    _scrollController = ScrollController()
      ..onScroll(() {
        try {
          ref.read(getCategoryBooksProvider.notifier).getMoreBooks(
                categoryName: widget.categoryName,
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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getCategoryBooksProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBGC,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.categoryName,
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => context.router.maybePop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.books.isEmpty
              ? const Center(child: Text('No books found'))
              : GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: state.hasNextPage
                      ? state.books.length + 1
                      : state.books.length,
                  itemBuilder: (context, index) {
                    if (index >= state.books.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final book = state.books[index];
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
    );
  }
}
