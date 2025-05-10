import 'package:bookly_app/components/default_progres_indicator.dart';
import 'package:bookly_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final bool isLoading;
  final bool enable;
  final Color? backgroundColor;
  final Color? textColor;
  final Size? size;
  final BorderRadiusGeometry? borderRadius;
  final Widget? icon;

  const DefaultButton({
    required this.title,
    this.onPressed,
    this.isLoading = false,
    this.enable = true,
    this.size = const Size(double.infinity, 50),
    super.key,
    this.backgroundColor = AppColors.primary,
    this.textColor = Colors.white,
    this.borderRadius,
    this.icon,
  });

  const DefaultButton.outlined({
    required this.title,
    this.onPressed,
    this.isLoading = false,
    this.enable = true,
    this.size = const Size(double.infinity, 50),
    super.key,
    this.borderRadius,
    this.icon,
  })  : backgroundColor = Colors.white,
        textColor = AppColors.primary;

  ButtonStyle _buttonStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ElevatedButton.styleFrom(
      minimumSize: size,
      animationDuration: const Duration(milliseconds: 100),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(30),
        side: backgroundColor == Colors.white
            ? const BorderSide(color: AppColors.primary)
            : BorderSide.none,
      ),
      elevation: 0.0,
      foregroundColor: AppColors.primary,
      textStyle: textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      disabledBackgroundColor: AppColors.disableButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enable && !isLoading ? onPressed : null,
      style: _buttonStyle(context),
      child: _buildButtonChild(context),
    );
  }

  Widget _buildButtonChild(BuildContext context) {
    if (isLoading) {
      return const DefaultProgressIndicator(
        size: 20,
        strokeWidth: 3,
        color: AppColors.primary,
      );
    }
    return Text(
      title,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
