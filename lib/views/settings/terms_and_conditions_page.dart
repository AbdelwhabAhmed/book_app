import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            'These are the Terms and Conditions.\n\nBy using this app, you agree to abide by our terms and conditions. Please read them carefully before using the app.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
