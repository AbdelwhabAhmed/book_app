import 'package:bookly_app/constants/app_colors.dart';
import 'package:bookly_app/constants/constants.dart';
import 'package:bookly_app/helpers/context_extension.dart';
import 'package:flutter/material.dart';

class TextFieldDecoration {
  TextFieldDecoration._();
  static InputDecoration getDecoration({
    required BuildContext context,
    Widget? suffixIcon,
    Widget? prefixIcon,
    String? hintText,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
  }) {
    return InputDecoration(
      contentPadding: contentPadding,
      fillColor: AppColors.fillColor,
      suffixIcon: suffixIcon,
      filled: true,
      hintText: hintText,
      hintStyle: context.textTheme.titleMedium!.copyWith(
        color: AppColors.hintColor,
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: prefixIcon,
      border: _getBorder(borderRadius),
      enabledBorder: _getBorder(borderRadius),
      focusedBorder: _getBorder(borderRadius),
      errorBorder: _getBorder(borderRadius, AppColors.error),
      focusedErrorBorder: _getBorder(borderRadius, AppColors.error),
    );
  }

  static InputBorder _getBorder([double? borderRadius, Color? color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius ?? Constants.textFieldBorderRadius),
      ),
      borderSide: BorderSide(color: color ?? Colors.transparent),
    );
  }
}
