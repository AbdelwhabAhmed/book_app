import 'package:auto_route/auto_route.dart';
import 'package:bookly_app/constants/app_colors.dart';
import 'package:bookly_app/helpers/context_extension.dart';
import 'package:bookly_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _shareApp() async {
    await Share.share('Share the app');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'App Information',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.share, color: AppColors.primary),
                  title: Text(
                    'Share the app',
                    style: TextStyle(color: AppColors.primary),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 16, color: AppColors.primary),
                  onTap: _shareApp,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.description, color: AppColors.primary),
                  title: Text(
                    'Terms and conditions',
                    style: TextStyle(color: AppColors.primary),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 16, color: AppColors.primary),
                  onTap: () {
                    context.router.push(const TermsAndConditionsRoute());
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.privacy_tip, color: AppColors.primary),
                  title: Text(
                    'Privacy policy',
                    style: TextStyle(color: AppColors.primary),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 16, color: AppColors.primary),
                  onTap: () {
                    context.router.push(const PrivacyPolicyRoute());
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // General Section
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'General',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.chat, color: AppColors.primary),
                  title: Text(
                    'Chat with admin',
                    style: TextStyle(color: AppColors.primary),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 16, color: AppColors.primary),
                  onTap: () {
                    context.router.push(const ChatWithAdminRoute());
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.logout, color: AppColors.primary),
                  title: Text(
                    'Log out',
                    style: TextStyle(color: AppColors.primary),
                  ),
                  onTap: () {
                    context.router.push(LoginRoute());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
