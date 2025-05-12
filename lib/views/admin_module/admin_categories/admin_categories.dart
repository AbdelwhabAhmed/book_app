import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bookly_app/helpers/scroll_helpers.dart';
import 'package:bookly_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookly_app/controller/providers/categories_provider.dart';

@RoutePage()
class AdminCategoriesPage extends ConsumerStatefulWidget {
  const AdminCategoriesPage({super.key});

  @override
  ConsumerState<AdminCategoriesPage> createState() =>
      _AdminCategoriesPageState();
}

class _AdminCategoriesPageState extends ConsumerState<AdminCategoriesPage> {
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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getCategoriesProvider);

    if (state.isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Categories')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (state.error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Categories')),
        body: Center(child: Text('Error: \\${state.error}')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: ListView.separated(
        controller: _scrollController,
        itemCount: state.categories.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final category = state.categories[index];
          return ListTile(
            title: Text(category.name),
            leading: Icon(Icons.category),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              context.router.push(AdminAddBookRoute(
                categoryId: category.id,
              ));
            },
          );
        },
      ),
    );
  }
}
