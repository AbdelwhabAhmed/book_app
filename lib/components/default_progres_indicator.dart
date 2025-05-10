import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class DefaultProgressIndicator extends StatelessWidget {
  final double? size;
  final double strokeWidth;
  final Color? color;
  final double? value;
  const DefaultProgressIndicator({
    super.key,
    this.size,
    this.color,
    this.strokeWidth = 4.0,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: 20,
        child: CircularProgressIndicator(
          backgroundColor: AppColors.borderColor,
          strokeWidth: 2,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
