import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bookly_app/components/default_button.dart';
import 'package:bookly_app/constants/app_colors.dart';
import 'package:bookly_app/controller/providers/categories_provider.dart';
import 'package:bookly_app/helpers/context_extension.dart';
import 'package:bookly_app/helpers/scroll_helpers.dart';
import 'package:bookly_app/model/categories/category_model.dart';
import 'package:bookly_app/router/router.gr.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class SelectionPage extends ConsumerStatefulWidget {
  const SelectionPage({super.key});

  @override
  ConsumerState<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends ConsumerState<SelectionPage> {
  final Set<String> selectedGenres = {};
  final int minimumGenres = 3;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(getCategoriesProvider.notifier).getCategories();
    });
    _scrollController = ScrollController()
      ..onScroll(() {
        try {
          ref.read(getCategoriesProvider.notifier).getMoreCategories();
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

  void toggleGenre(String genre) {
    setState(() {
      if (selectedGenres.contains(genre)) {
        selectedGenres.remove(genre);
      } else {
        selectedGenres.add(genre);
      }
    });
  }

  void submit() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    try {
      ref.read(getCategoriesProvider.notifier).selectCategories(
            categoryIds: selectedGenres.toList(),
            userId: userId!,
          );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Categories selected successfully'),
          backgroundColor: Colors.green,
        ),
      );
      context.router.push(const MainRoute());
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: context.textTheme.bodyMedium!.copyWith(
              color: Colors.red,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getCategoriesProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SelectionPageTitle(),
              const SizedBox(height: 24),
              GenresCounter(
                selectedCount: selectedGenres.length,
                minimumGenres: minimumGenres,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GenresGrid(
                  categories: state.categories,
                  selectedGenres: selectedGenres,
                  onGenreToggle: toggleGenre,
                  scrollController: _scrollController,
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              DefaultButton(
                title: 'Next',
                enable: selectedGenres.length >= minimumGenres,
                onPressed: submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectionPageTitle extends StatelessWidget {
  const SelectionPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Select the genres for which you want to receive recommendations',
      style: context.textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
    );
  }
}

class GenresGrid extends StatelessWidget {
  final List<CategoryModel> categories;
  final Set<String> selectedGenres;
  final Function(String) onGenreToggle;
  final ScrollController scrollController;

  const GenresGrid({
    super.key,
    required this.categories,
    required this.selectedGenres,
    required this.onGenreToggle,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 32,
        childAspectRatio: 4,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final genre = categories[index];
        return GenreItem(
          name: genre.name,
          isSelected: selectedGenres.contains(genre.id),
          onTap: () => onGenreToggle(genre.id),
        );
      },
    );
  }
}

class GenreItem extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const GenreItem({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: isSelected
              ? Border.all(
                  color: AppColors.primary,
                  width: 2,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              name,
              style: context.textTheme.titleMedium!.copyWith(
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GenresCounter extends StatelessWidget {
  final int selectedCount;
  final int minimumGenres;

  const GenresCounter({
    super.key,
    required this.selectedCount,
    required this.minimumGenres,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$selectedCount/$minimumGenres minimum',
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontFamily: 'SF Pro Display',
      ),
    );
  }
}
