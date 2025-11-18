import 'package:flutter/material.dart';

class LogoKeys {
  static const String logoKey = 'assets/images/logo.png';
}

// APP COLORS
class AppColors {
  static const Color primaryNavy = Color(0xFF1A2332);
  static const Color gold = Color(0xFFD4AF37);
  static const Color background = Color(0xFFF8F9FB);
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color navyDark = Color(0xFF0F172A);
  static const Color navyLight = Color(0xFF2D3748);
  static const Color error = Colors.redAccent;
}

// TEXT STYLES

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle subHeading = TextStyle(
    fontSize: 20,
    color: Colors.grey,
  );

  static const TextStyle label = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle inputHint = TextStyle(
    color: Colors.grey,
    fontSize: 16,
  );

  static const TextStyle button = TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle smallText = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );
}

// TEXT FIELD DECORATION

class AppInputDecoration {
  static InputDecoration rounded({
    required String hintText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixTap,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyles.inputHint,
      filled: true,
      fillColor: Colors.grey.shade200,
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: Colors.grey)
          : null,
      suffixIcon: suffixIcon != null
          ? IconButton(
              onPressed: onSuffixTap,
              icon: Icon(suffixIcon, color: Colors.grey),
            )
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: AppColors.gold),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    );
  }
}

// BUTTON STYLES

class AppButtons {
  static ButtonStyle primary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryNavy,
    foregroundColor: Colors.white,
    minimumSize: const Size(150, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    textStyle: AppTextStyles.button,
  );

  static ButtonStyle secondary = OutlinedButton.styleFrom(
    side: const BorderSide(color: AppColors.gold, width: 1.5),
    foregroundColor: AppColors.gold,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );

  static ButtonStyle text = TextButton.styleFrom(
    foregroundColor: AppColors.gold,
    padding: EdgeInsets.zero,
    minimumSize: const Size(0, 0),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}

// SPACING

class AppSpacing {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
}

// COMMON WIDGETS

class AppWidgets {
  static Widget logo(String path, {double size = 200}) =>
      Image.asset(path, height: size, width: size);

  static Widget heading(String text) =>
      Text(text, style: AppTextStyles.heading, textAlign: TextAlign.center);

  static Widget subtitle(String text) => FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      text,
      style: AppTextStyles.subHeading,
      textAlign: TextAlign.center,
    ),
  );

  static Widget verticalSpace(double height) => SizedBox(height: height);
  static Widget horizontalSpace(double width) => SizedBox(width: width);
}
