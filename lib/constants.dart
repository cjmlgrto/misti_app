import 'package:flutter/material.dart';

class AppColors {
  static const Color label = Colors.black;
  static const Color background = Colors.white;

  static const Color accentPrimary = Color.fromRGBO(4, 161, 171, 1);
  static const Color surfacePrimary = Color.fromRGBO(229, 245, 246, 1);

  static const Color accentSecondary = Color.fromRGBO(63, 107, 149, 1);
  static const Color surfaceSecondary = Color.fromRGBO(229, 244, 250, 1);

  static const Color accentTertiary = Color.fromRGBO(149, 134, 96, 1);
  static const Color surfaceTertiary = Color.fromRGBO(248, 245, 231, 1);

  static const Color buttonBackground = Colors.white;
}

class TextStyles {
  static const TextStyle title = TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w700,
      color: AppColors.label,
      letterSpacing: -1.4);

  static const TextStyle subtitle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: AppColors.label,
      letterSpacing: -0.4);

  static const TextStyle body = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color: AppColors.label,
      letterSpacing: -0.4);

  static const TextStyle caption = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: AppColors.label,
      letterSpacing: -0.4);
}

class ButtonStyles {
  static ButtonStyle buttonPrimary = ButtonStyle(
      textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.4,
          inherit: false)),
      foregroundColor:
          const MaterialStatePropertyAll<Color>(AppColors.accentPrimary),
      backgroundColor:
          const MaterialStatePropertyAll<Color>(AppColors.buttonBackground),
      fixedSize: const MaterialStatePropertyAll<Size?>(Size.fromWidth(160)),
      shadowColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(16.0)),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))));

  static ButtonStyle buttonMiniPrimary = ButtonStyle(
      textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.4,
          inherit: false)),
      foregroundColor:
          const MaterialStatePropertyAll<Color>(AppColors.accentPrimary),
      backgroundColor:
          const MaterialStatePropertyAll<Color>(AppColors.buttonBackground),
      shadowColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(48.0))));

  static ButtonStyle buttonSecondary = ButtonStyle(
      textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.4,
          inherit: false)),
      foregroundColor:
          const MaterialStatePropertyAll<Color>(AppColors.accentSecondary),
      backgroundColor:
          const MaterialStatePropertyAll<Color>(AppColors.buttonBackground),
      fixedSize: const MaterialStatePropertyAll<Size?>(Size.fromWidth(160)),
      shadowColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(8.0)),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))));

  static ButtonStyle buttonMiniSecondary = ButtonStyle(
      textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.4,
          inherit: false)),
      foregroundColor:
          const MaterialStatePropertyAll<Color>(AppColors.accentSecondary),
      backgroundColor:
          const MaterialStatePropertyAll<Color>(AppColors.buttonBackground),
      shadowColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(48.0))));

  static ButtonStyle buttonTertiary = ButtonStyle(
      textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.4,
          inherit: false)),
      foregroundColor:
          const MaterialStatePropertyAll<Color>(AppColors.accentTertiary),
      backgroundColor:
          const MaterialStatePropertyAll<Color>(AppColors.surfaceTertiary),
      fixedSize: const MaterialStatePropertyAll<Size?>(Size.fromWidth(160)),
      shadowColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(24.0)),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))));
}

class Strings {
  static const String deviceHelpTitle = "Device Troubleshooting";
  static const String dosageGuideTitle = "Dosage Guide";
  static const String gettingStartedGuideTitle = "Getting Started";

  static const String genericHelpText = """ 
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.

Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
  """;
}
