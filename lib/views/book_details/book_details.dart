import 'package:auto_route/auto_route.dart';
import 'package:bookly_app/components/default_button.dart';
import 'package:bookly_app/constants/app_colors.dart';
import 'package:bookly_app/constants/constants.dart';
import 'package:bookly_app/controller/providers/similier_books.provider.dart';
import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/controller/providers/all_books_provider.dart';
import 'package:bookly_app/controller/providers/get_favorite_provider.dart';
import 'package:bookly_app/controller/providers/history_provider.dart';
import 'package:bookly_app/helpers/context_extension.dart';
import 'package:bookly_app/model/book_model/book_model.dart';
import 'package:bookly_app/router/router.gr.dart';
import 'package:bookly_app/views/home/widgets/book_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

@RoutePage()
class BookDetailsPage extends ConsumerStatefulWidget {
  final BookModel book;
  const BookDetailsPage({super.key, required this.book});

  @override
  ConsumerState<BookDetailsPage> createState() => _BookDetailsState();
}

class _BookDetailsState extends ConsumerState<BookDetailsPage> {
  final List<Map<String, dynamic>> similarBooks = [
    {
      'imageUrl':
          'https://m.media-amazon.com/images/I/61EYrVHLluL._AC_UF1000,1000_QL80_.jpg',
      'title': 'Siddhartha',
      'author': 'Hermann Hesse',
      'rating': 4.5,
    },
    {
      'imageUrl':
          'https://m.media-amazon.com/images/I/71GM68EeZfL._UF1000,1000_QL80_.jpg',
      'title': 'The Pilgrimage',
      'author': 'Paulo Coelho',
      'rating': 4.3,
    },
    {
      'imageUrl':
          'https://m.media-amazon.com/images/I/61+8wwQ2JsL._AC_UF1000,1000_QL80_.jpg',
      'title': 'The Prophet',
      'author': 'Kahlil Gibran',
      'rating': 4.7,
    },
  ];

  double _userRating = 0;
  Future<void> toggleFavorite() async {
    final prefs = ref.read(prefsProvider);
    final userId = prefs.getString(Constants.userId);
    await ref.read(getBooksProvider.notifier).toggleFavorite(
          widget.book.id,
          userId!,
        );
    setState(() {
      widget.book.isFavorite = !widget.book.isFavorite;
    });
  }

  Future<void> addReview() async {
    final prefs = ref.read(prefsProvider);
    final userId = prefs.getString(Constants.userId);
    await ref.read(getBooksProvider.notifier).addReview(
          widget.book.id,
          userId!,
          _userRating.toInt(),
        );
  }

  Future<void> addHistory() async {
    final prefs = ref.read(prefsProvider);
    final userId = prefs.getString(Constants.userId);
    await ref.read(getBooksProvider.notifier).addHistory(
          userId!,
          widget.book.id,
        );
    await ref.read(getHistoryProvider.notifier).getHistory(userId: userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Section with orange background
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Back button and favorite
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      IconButton(
                        icon: Icon(
                          widget.book.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: toggleFavorite,
                      ),
                    ],
                  ),
                  // Book cover
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: 200,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: widget.book.fileUrl ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: context.height * 0.95,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.book.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              widget.book.author,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${widget.book.averageRating.toStringAsFixed(1)}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Book Type Badge
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(
                                  0xFF2962A6), // A blue shade, adjust as needed
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Text(
                              widget.book.categoryName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Description
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            widget.book.description,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        DefaultButton(
                          title: 'Read Now',
                          onPressed: () async {
                            launchUrl(Uri.parse(
                                'https://kvongcmehsanalibrary.wordpress.com/wp-content/uploads/2021/07/harrypotter.pdf'));
                            await addHistory();
                          },
                        ),
                        const SizedBox(height: 24),

                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => RateBookDialog(
                                onSubmit: addReview,
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                colors: [Color(0xFFFFD600), Color(0xFFFFA000)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star, color: Colors.white, size: 24),
                                SizedBox(width: 10),
                                Text(
                                  'Rate this book',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Similar Books Section
                        Text(
                          'More Like ${widget.book.name}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SimilarBooksSection(bookId: widget.book.id),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RateBookDialog extends StatefulWidget {
  final VoidCallback onSubmit;
  const RateBookDialog({super.key, required this.onSubmit});

  @override
  _RateBookDialogState createState() => _RateBookDialogState();
}

class _RateBookDialogState extends State<RateBookDialog> {
  double? _rating;
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _submitted ? Text('') : Text('Rate this book'),
      content: _submitted
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 48),
                SizedBox(height: 16),
                Text('Thank you for your rating!'),
              ],
            )
          : RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
                size: 36,
              ),
              unratedColor: Colors.grey[400],
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (mounted) {
                    setState(() {
                      _submitted = true;
                    });
                  }
                });
                widget.onSubmit();
              },
            ),
      actions: [
        if (_submitted)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
      ],
    );
  }
}

class SimilarBooksSection extends ConsumerStatefulWidget {
  final String bookId;
  const SimilarBooksSection({super.key, required this.bookId});

  @override
  ConsumerState<SimilarBooksSection> createState() =>
      _SimilarBooksSectionState();
}

class _SimilarBooksSectionState extends ConsumerState<SimilarBooksSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final prefs = ref.read(prefsProvider);
      final userId = prefs.getString(Constants.userId);
      ref.read(getSimilarBooksProvider.notifier).getSimilarBooks(
            userId: userId ?? '',
            bookId: widget.bookId,
          );
      print(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getSimilarBooksProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Please wait while we analyze your data...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          )
        else if (state.error != null)
          Center(
            child: Text(
              state.error.toString(),
              style: context.textTheme.bodyMedium,
            ),
          )
        else if (state.similarBooks.isEmpty)
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
              itemCount: state.similarBooks.length,
              itemBuilder: (context, index) {
                final book = state.similarBooks[index];
                return Container(
                  width: 160,
                  margin: EdgeInsets.only(
                    right: index == state.similarBooks.length - 1 ? 0 : 16,
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
