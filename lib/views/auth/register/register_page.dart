import 'package:auto_route/auto_route.dart';
import 'package:bookly_app/cach_data.dart';
import 'package:bookly_app/components/default_button.dart';
import 'package:bookly_app/components/default_text_field%20copy.dart';
import 'package:bookly_app/controller/providers/register_provider.dart';
import 'package:bookly_app/generated/assets.gen.dart';
import 'package:bookly_app/helpers/context_extension.dart';
import 'package:bookly_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    await ref.read(registerProvider.notifier).register(
        emailController.text.trim(),
        phoneController.text.trim(),
        nameController.text.trim(),
        passwordController.text.trim());
    print(userId);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<RegisterState>(
      registerProvider,
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
          CacheData.saveString('userId', next.message!);
          CacheData.saveString('username', next.message!);

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
          context.router.push(const SelectionRoute());
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
                  'Create An Account!',
                  style: context.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Assets.images.png.login.image(
                width: 300,
                height: 300,
              ),
              DefaultTextField(
                outLineText: 'Name',
                hintText: 'Enter your name',
                controller: nameController,
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),
              DefaultTextField(
                outLineText: 'email',
                hintText: 'Enter your email',
                controller: emailController,
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),
              DefaultTextField(
                outLineText: 'phone number',
                hintText: 'Enter your phone number',
                controller: phoneController,
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),
              DefaultTextField(
                  outLineText: 'Password',
                  hintText: 'Enter your password',
                  isPassword: true,
                  controller: passwordController,
                  validator: FormBuilderValidators.required()),
              const SizedBox(height: 50),
              DefaultButton(
                title: 'Register',
                onPressed: register,
              ),
              const SizedBox(height: 16),
              DefaultButton.outlined(
                title: 'Already have an account? Login',
                onPressed: () {
                  context.router.push(LoginRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
