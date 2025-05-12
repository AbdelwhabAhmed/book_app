import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bookly_app/constants/constants.dart';
import 'package:bookly_app/controller/providers/add_book_provider.dart';
import 'package:bookly_app/controller/service_provider.dart';
import 'package:bookly_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:bookly_app/constants/app_colors.dart';
import 'package:bookly_app/components/default_button.dart';
import 'package:bookly_app/components/default_text_field copy.dart';
import 'package:bookly_app/helpers/context_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class AdminAddBookPage extends ConsumerStatefulWidget {
  final String categoryId;
  const AdminAddBookPage({super.key, required this.categoryId});

  @override
  ConsumerState<AdminAddBookPage> createState() => _AdminAddBookPageState();
}

class _AdminAddBookPageState extends ConsumerState<AdminAddBookPage> {
  final nameController = TextEditingController();
  final authorController = TextEditingController();
  final ratingController = TextEditingController();
  final descriptionController = TextEditingController();
  final fileUrlController = TextEditingController();
  final publishedYearController = TextEditingController();
  final numPagesController = TextEditingController();
  final linkBookController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  Future<void> addBook() async {
    if (!formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    final userId = ref.read(prefsProvider).getString(Constants.userId);

    await ref.read(addBookProvider.notifier).addBook(
          userId ?? '',
          widget.categoryId,
          nameController.text.trim(),
          authorController.text.trim(),
          descriptionController.text.trim(),
          fileUrlController.text.trim(),
          int.tryParse(publishedYearController.text.trim()) ?? 0,
          double.tryParse(ratingController.text.trim()) ?? 0,
          int.tryParse(numPagesController.text.trim()) ?? 0,
          linkBookController.text.trim(),
        );
  }

  Future<File?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    authorController.dispose();
    ratingController.dispose();
    descriptionController.dispose();
    fileUrlController.dispose();
    publishedYearController.dispose();
    numPagesController.dispose();
    linkBookController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AddBookState>(
      addBookProvider,
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
          context.router.replace(const AdminHomeRoute());
        }
      },
    );
    return Scaffold(
      backgroundColor: AppColors.scaffoldBGC,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Add Book',
          style: context.textTheme.headlineSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              child: Container(
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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              final file = await pickImageFromGallery();
                              if (file != null) {
                                fileUrlController.text = file.path;
                              }
                            },
                            child: Container(
                              width: 100,
                              height: 140,
                              decoration: BoxDecoration(
                                color: AppColors.scaffoldBGC,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: AppColors.primary, width: 1.5),
                              ),
                              child: Icon(Icons.image,
                                  size: 48,
                                  color: AppColors.primary.withOpacity(0.5)),
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: CircleAvatar(
                              backgroundColor: AppColors.primary,
                              radius: 18,
                              child: Icon(Icons.camera_alt,
                                  color: Colors.white, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    DefaultTextField(
                        outLineText: 'Book Name',
                        hintText: 'Enter book name',
                        controller: nameController,
                        validator: FormBuilderValidators.required()),
                    const SizedBox(height: 16),
                    DefaultTextField(
                      outLineText: 'Author',
                      hintText: 'Enter author name',
                      controller: authorController,
                      validator: FormBuilderValidators.required(),
                    ),
                    const SizedBox(height: 16),
                    DefaultTextField(
                      outLineText: 'Description',
                      hintText: 'Enter description',
                      controller: descriptionController,
                      validator: FormBuilderValidators.required(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultTextField(
                            outLineText: 'Published Year',
                            hintText: 'Enter published year',
                            controller: publishedYearController,
                            keyboardType: TextInputType.number,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.numeric(),
                              FormBuilderValidators.max(2025),
                            ]),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DefaultTextField(
                            outLineText: 'Rating',
                            hintText: 'Enter rating (e.g. 4.5)',
                            controller: ratingController,
                            keyboardType: TextInputType.number,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.numeric(),
                              FormBuilderValidators.max(5),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DefaultTextField(
                      outLineText: 'Link Book',
                      hintText: 'Enter link book',
                      controller: linkBookController,
                    ),
                    const SizedBox(height: 32),
                    DefaultButton(
                      title: 'Add Book',
                      onPressed: addBook,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
