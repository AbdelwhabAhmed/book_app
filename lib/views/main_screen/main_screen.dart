import 'package:auto_route/auto_route.dart';
import 'package:bookly_app/components/default_nav_bar.dart';
import 'package:bookly_app/constants/app_colors.dart';
import 'package:bookly_app/controller/providers/main_page_provider.dart';
import 'package:bookly_app/model/nav_bar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(navigationProvider);
    return Scaffold(
      backgroundColor: AppColors.borderColor2,
      body: DefaultNavBar(
        navItems: BottomNavBarData.navBarData,
        screens: provider.screens,
        onItemSelected: provider.changeScreen,
      ),
    );
  }
}
