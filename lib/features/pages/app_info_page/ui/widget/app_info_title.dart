import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/config/const/sensei_const.dart';

class AppInfoTitle extends StatelessWidget {
  const AppInfoTitle({super.key});

  @override
  /// Builds a centered column containing the app's image, title, and copyright information.
  ///
  /// The column includes:
  /// - An image of the application wrapped in a [ClipRRect] with rounded corners.
  /// - A text widget displaying the app's name "تطبيق تَضَامُنٌ" in bold font.
  /// - A text widget displaying copyright information with dynamic year range based on the current year.
  ///
  /// The container holding the image is styled with padding, rounded borders, and a border color
  /// derived from the current theme. The text widgets are centered and styled according to the
  /// theme's color scheme.
  Widget build(final BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(SenseiConst.padding),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withAlpha(0x80),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
            child: Image.asset(
              SenseiConst.tadamonAppImage,
              width: 120.w,
              height: 120.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          'تطبيق تَضَامُنٌ',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Text(
            "© 2025${DateTime.now().year > 2025 ? ' - ${DateTime.now().year}' : ''} - جميع الحقوق محفوظة بموجب GNU GENERAL PUBLIC LICENSE v3.0",
            style: TextStyle(
              fontSize: 12.sp,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
