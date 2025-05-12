import 'package:auto_route/auto_route.dart';
import 'package:bookly_app/constants/app_colors.dart';
import 'package:bookly_app/constants/constants.dart';
import 'package:bookly_app/controller/providers/all_books_provider.dart';
import 'package:bookly_app/controller/providers/recommended_provider.dart';
import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/helpers/context_extension.dart';
import 'package:bookly_app/router/router.gr.dart';
import 'package:bookly_app/views/home/widgets/book_card.dart';
import 'package:bookly_app/views/home/widgets/carousal_widget.dart';
import 'package:bookly_app/views/home/widgets/categories_section.dart';
import 'package:bookly_app/views/home/widgets/top_categoris_books.dart';
import 'package:bookly_app/views/home/widgets/top_rated_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBGC,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBGC,
        elevation: 0,
        forceMaterialTransparency: true,
        title: Text(
          'Bookly',
          style: context.textTheme.headlineLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.router.push(const SearchRoute());
            },
            icon: const Icon(Icons.search),
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 24),
            CarouselSection(),
            const SizedBox(height: 24),
            CategoriesSection(),
            const SizedBox(height: 24),
            // FeaturedSection(),
            TopCategorisBooks(),
            const SizedBox(height: 24),
            TopRatedSection(),
            const SizedBox(height: 24),
            RecommendedSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class FeaturedSection extends ConsumerStatefulWidget {
  const FeaturedSection({super.key});

  @override
  ConsumerState<FeaturedSection> createState() => _FeaturedSectionState();
}

class _FeaturedSectionState extends ConsumerState<FeaturedSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(getBooksProvider.notifier).getBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getBooksProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.router.push(AllBooksRoute());
                },
                child: Text(
                  'See All',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 320,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: state.books.length,
            itemBuilder: (context, index) {
              final book = state.books[index];
              return Container(
                width: 160,
                margin: EdgeInsets.only(
                  right: index == state.books.length - 1 ? 0 : 16,
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

class RecommendedSection extends ConsumerStatefulWidget {
  const RecommendedSection({super.key});

  @override
  ConsumerState<RecommendedSection> createState() => _RecommendedSectionState();
}

class _RecommendedSectionState extends ConsumerState<RecommendedSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final prefs = ref.read(prefsProvider);
      final userId = prefs.getString(Constants.userId);
      ref.read(getRecommendedBooksProvider.notifier).getRecommendedBooks(
            userId: userId ?? '',
            // userId: (Random().nextInt(500) + 1).toString(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getRecommendedBooksProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        if (state.isLoading)
          const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          )
        // const Center(
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(vertical: 32.0),
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         CircularProgressIndicator(
        //           color: AppColors.primary,
        //         ),
        //         SizedBox(height: 24),
        //         Text(
        //           'Please wait while we analyze your data...',
        //           style: TextStyle(
        //             fontSize: 16,
        //             fontWeight: FontWeight.w500,
        //             color: AppColors.primary,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // )
        else if (state.error != null)
          Center(
            child: Text(
              'No',
              style: context.textTheme.bodyMedium,
            ),
          )
        else if (state.recommendedBooks.isEmpty)
          const Center(
            child: Text('No  books found'),
          )
        else
          SizedBox(
            height: 320,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: state.recommendedBooks.length,
              itemBuilder: (context, index) {
                final book = state.recommendedBooks[index];
                return Container(
                  width: 160,
                  margin: EdgeInsets.only(
                    right: index == state.recommendedBooks.length - 1 ? 0 : 16,
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
