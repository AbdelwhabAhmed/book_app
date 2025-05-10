import 'package:auto_route/auto_route.dart';
import 'package:bookly_app/cach_data.dart';
import 'package:bookly_app/components/default_button.dart';
import 'package:bookly_app/components/default_text_field%20copy.dart';
import 'package:bookly_app/controller/providers/login_provider.dart';
import 'package:bookly_app/controller/services/auth_service.dart';
import 'package:bookly_app/generated/assets.gen.dart';
import 'package:bookly_app/helpers/context_extension.dart';
import 'package:bookly_app/helpers/http_client.dart';
import 'package:bookly_app/router/router.gr.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  final AuthService authService = AuthService(ApiClient(Dio()));

  LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    await ref
        .read(loginProvider.notifier)
        .login(emailController.text.trim(), passwordController.text.trim());
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<LoginState>(
      loginProvider,
      (_, next) async {
        if (next.isLoading) return;

        if (next.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error.toString()),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
          return;
        }

        if (next.message != null) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.message!),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          // Wait a moment so user can see the message
          await Future.delayed(const Duration(milliseconds: 500));
          context.router.push(const MainRoute());
        }
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              Center(
                child: Text(
                  'Login Into Your Account!',
                  style: context.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Assets.images.png.login.image(
                width: 300,
                height: 300,
              ),
              DefaultTextField(
                  outLineText: 'Email',
                  hintText: 'Enter your email',
                  controller: emailController,
                  validator: FormBuilderValidators.required()),
              const SizedBox(height: 16),
              DefaultTextField(
                  outLineText: 'Password',
                  hintText: 'Enter your password',
                  controller: passwordController,
                  isPassword: true,
                  validator: FormBuilderValidators.required()),
              const SizedBox(height: 50),
              DefaultButton(
                title: 'Login',
                onPressed: login,
              ),
              const SizedBox(height: 16),
              DefaultButton.outlined(
                title: 'Create An Account',
                onPressed: () {
                  context.router.push(const RegisterRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
