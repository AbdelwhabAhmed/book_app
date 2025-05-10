import 'package:bookly_app/constants/app_colors.dart';
import 'package:bookly_app/helpers/text_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefaultTextField extends ConsumerStatefulWidget {
  final String outLineText;
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;
  final int? maxLength;
  final bool isPassword;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? extraHint;
  final Function(String)? onChanged;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? borderRadius;
  const DefaultTextField({
    required this.outLineText,
    required this.hintText,
    required this.controller,
    super.key,
    this.validator,
    this.maxLength,
    this.onTap,
    this.inputFormatters,
    this.readOnly = false,
    this.isPassword = false,
    this.maxLines = 1,
    this.keyboardType,
    this.extraHint,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.textAlign = TextAlign.start,
    this.borderRadius,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DefaultTextFieldState();
}

class _DefaultTextFieldState extends ConsumerState<DefaultTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.outLineText.isNotEmpty) ...[
          Text(
            widget.outLineText,
            style: textTheme.titleMedium!.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Stack(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor.withOpacity(0.10),
                    blurRadius: 16,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
            TextFormField(
              maxLength: widget.maxLength,
              onChanged: widget.onChanged,
              keyboardType: widget.keyboardType,
              cursorColor: AppColors.primary,
              decoration: TextFieldDecoration.getDecoration(
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : widget.suffixIcon,
                prefixIcon: widget.prefixIcon,
                context: context,
                hintText: widget.hintText,
                contentPadding: widget.contentPadding,
                borderRadius: widget.borderRadius,
              ),
              textAlign: widget.textAlign,
              onTap: widget.onTap,
              validator: widget.validator,
              controller: widget.controller,
              readOnly: widget.readOnly,
              inputFormatters: widget.inputFormatters,
              maxLines: widget.maxLines,
              obscureText: widget.isPassword ? _obscureText : false,
            ),
          ],
        ),
      ],
    );
  }
}
