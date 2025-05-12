import 'package:auto_route/auto_route.dart';
import 'package:bookly_app/constants/constants.dart';
import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:bookly_app/constants/app_colors.dart';
import 'package:bookly_app/helpers/context_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class AdminHomePage extends ConsumerWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.read(prefsProvider);
    String? userName = prefs.getString(Constants.username);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBGC,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Admin Home',
          style: context.textTheme.headlineSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.admin_panel_settings,
                        size: 64, color: AppColors.primary),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome, $userName!',
                      style: context.textTheme.titleLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Manage your app from here',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.hintColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context.router.push(AdminCategoriesRoute()),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 28),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.12),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add_box, color: Colors.white, size: 36),
                            const SizedBox(height: 10),
                            Text(
                              'Add Book',
                              style: context.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context.router.push(const AdminChatRoute()),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 28),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.12),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                          border:
                              Border.all(color: AppColors.primary, width: 1.5),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.chat,
                                color: AppColors.primary, size: 36),
                            const SizedBox(height: 10),
                            Text(
                              'Chat',
                              style: context.textTheme.titleMedium?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
