import 'package:flutter/material.dart';
import 'package:pp692/ui_kit/colors.dart';

abstract class AppStyles {
  static const displayXL = TextStyle(
    fontFamily: 'Finlandica',
    height: 1.1428571428571428,
    fontSize: 42,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );
  static const displayLarge = TextStyle(
    fontFamily: 'Finlandica',
    height: 1.125,
    fontSize: 32,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurface,
  );
  static const displayMedium = TextStyle(
    fontFamily: 'Finlandica',
    height: 1.1666666666666667,
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurface,
  );
  static const displaySmall = TextStyle(
    fontFamily: 'Finlandica',
    height: 1.1111111111111112,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurface,
  );
  static const bodyLarge = TextStyle(
    fontFamily: 'Finlandica',
    height: 1.25,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );
  static const bodyMedium = TextStyle(
    fontFamily: 'Finlandica',
    height: 1.4285714285714286,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );
  static const bodySmall = TextStyle(
    fontFamily: 'Finlandica',
    height: 1.2727272727272727,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );
}
