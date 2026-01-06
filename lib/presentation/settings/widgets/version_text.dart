import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';

class VersionText extends StatelessWidget {
  const VersionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Movin Real Estate Platform\nVersion 1.0.0',
      textAlign: TextAlign.center,
      style: AppTextStyles.smallText,
    );
  }
}
