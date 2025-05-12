import 'package:auto_route/auto_route.dart';
import 'package:bookly_app/constants/constants.dart';
import 'package:bookly_app/controller/providers/get_favorite_provider.dart';
import 'package:bookly_app/controller/providers/history_provider.dart';
import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/controller/services/auth_service.dart';
import 'package:bookly_app/helpers/context_extension.dart';
import 'package:bookly_app/helpers/http_client.dart';
import 'package:bookly_app/router/router.gr.dart';
import 'package:bookly_app/views/home/widgets/book_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ProfilePage extends ConsumerStatefulWidget {
  final AuthService authService = AuthService(ApiClient(Dio()));

  ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  String? userName;
  String? profilePicture;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    final prefs = ref.read(prefsProvider);
    userName = prefs.getString(Constants.username);
    profilePicture = prefs.getString(Constants.profilePicture);
  }

  @override
  Widget build(BuildContext context) {
    print(userName);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          userName ?? '',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.router.push(const SettingsRoute());
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: profilePicture ?? '',
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              HistorySection(title: '$userName\'s History'),
              const SizedBox(height: 16),
              FavoriteSection(title: '$userName\'s Favorites'),
              const SizedBox(height: 32),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteSection extends ConsumerStatefulWidget {
  final String title;
  const FavoriteSection({super.key, required this.title});

  @override
  ConsumerState<FavoriteSection> createState() => _FavoriteSectionState();
}

class _FavoriteSectionState extends ConsumerState<FavoriteSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final prefs = ref.read(prefsProvider);
      final userId = prefs.getString(Constants.userId);
      if (userId != null && userId.isNotEmpty) {
        ref.read(getFavoriteBooksProvider.notifier).getFavorites(
              userId: userId,
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getFavoriteBooksProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (state.isLoading)
          const Center(child: CircularProgressIndicator())
        else if (state.error != null)
          Center(child: Text(state.error!.toString()))
        else
          SizedBox(
            height: 320,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: state.favoriteBooks.length,
              itemBuilder: (context, index) {
                final book = state.favoriteBooks[index];
                return Container(
                  width: 160,
                  margin: EdgeInsets.only(
                    right: index == state.favoriteBooks.length - 1 ? 0 : 16,
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

class HistorySection extends ConsumerStatefulWidget {
  final String title;
  const HistorySection({super.key, required this.title});

  @override
  ConsumerState<HistorySection> createState() => _HistorySectionState();
}

class _HistorySectionState extends ConsumerState<HistorySection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final prefs = ref.read(prefsProvider);
      final userId = prefs.getString(Constants.userId);
      if (userId != null && userId.isNotEmpty) {
        ref.read(getHistoryProvider.notifier).getHistory(
              userId: userId,
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getHistoryProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (state.isLoading)
          const Center(child: CircularProgressIndicator())
        else if (state.error != null)
          Center(child: Text(state.error!.toString()))
        else
          SizedBox(
            height: 320,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: state.historyBooks.length,
              itemBuilder: (context, index) {
                final book = state.historyBooks[index];
                return Container(
                  width: 160,
                  margin: EdgeInsets.only(
                    right: index == state.historyBooks.length - 1 ? 0 : 16,
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
