import 'package:flutter/material.dart' show Theme;
import 'package:flutter/widgets.dart' show TextStyle, BuildContext, FontWeight;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle headline1(BuildContext context) => TextStyle(
    fontSize: 34.sp,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.onPrimary,
  );

  static TextStyle headline2(BuildContext context) => TextStyle(
    fontSize: 24.sp,
    //fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.onPrimary,
  );

  static TextStyle bodyText1(BuildContext context) => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onPrimary,
  );

  static TextStyle bodyText2(BuildContext context) => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onPrimary,
  );

  static TextStyle button(BuildContext context) => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.onPrimary,
  );

  static TextStyle hint(BuildContext context) => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onPrimary.withAlpha(0x50),
  );

  static TextStyle disabled(BuildContext context) => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onPrimary.withAlpha(0x20),
  );

  static TextStyle caption(BuildContext context) => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onPrimary,
  );

  static TextStyle captionLight(BuildContext context) => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onPrimary.withAlpha(0x50),
  );

  static TextStyle subtitle(BuildContext context) => TextStyle(
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    fontFamily: 'ArabicFont',
  );
}
