import 'package:auto_route/auto_route.dart';
import 'package:bookly_app/controller/providers/top_rated_provider.dart';
import 'package:bookly_app/helpers/context_extension.dart';
import 'package:bookly_app/router/router.gr.dart';
import 'package:bookly_app/views/home/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopRatedSection extends ConsumerStatefulWidget {
  const TopRatedSection({super.key});

  @override
  ConsumerState<TopRatedSection> createState() => _TopRatedSectionState();
}

class _TopRatedSectionState extends ConsumerState<TopRatedSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(getTopRatedBooksProvider.notifier).getTopRatedBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getTopRatedBooksProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Rated',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              // TextButton(
              //   onPressed: () {
              //     context.router.push(AllBooksRoute());
              //   },
              //   child: Text(
              //     'See All',
              //     style: context.textTheme.titleMedium?.copyWith(
              //       color: AppColors.primary,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        SizedBox(
          height: 320,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: state.topRatedBooks.length,
            itemBuilder: (context, index) {
              final book = state.topRatedBooks[index];
              return Container(
                width: 160,
                margin: EdgeInsets.only(
                  right: index == state.topRatedBooks.length - 1 ? 0 : 16,
                ),
                child: BookCard(
                  book: book,
                  onTap: () {
                    context.router.push(BookDetailsRoute(
                      book: book,
                    ));
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
