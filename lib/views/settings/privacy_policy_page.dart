import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            'This is the Privacy Policy.\n\nYour privacy is important to us. We do not collect personal information except as necessary to provide our services. Please read this policy carefully.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
