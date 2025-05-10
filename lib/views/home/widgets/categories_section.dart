import 'package:auto_route/auto_route.dart';
import 'package:bookly_app/constants/app_colors.dart';
import 'package:bookly_app/controller/providers/categories_provider.dart';
import 'package:bookly_app/helpers/context_extension.dart';
import 'package:bookly_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesSection extends ConsumerStatefulWidget {
  const CategoriesSection({super.key});

  @override
  ConsumerState<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends ConsumerState<CategoriesSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(getCategoriesProvider.notifier).getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getCategoriesProvider);
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.error != null) {
      return Center(
        child: Text(state.error.toString()),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Categories',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  context.router.push(AllCategoriesRoute());
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
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return InkWell(
                  onTap: () {
                    context.router.push(CategoryBooksRoute(
                      categoryName: category.name,
                    ));
                  },
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          offset: const Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.category,
                          color: Colors.white,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.name,
                          style: context.textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
