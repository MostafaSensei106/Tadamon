import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class AppInfoTitle extends StatelessWidget {
  const AppInfoTitle({super.key});
  @override
  /// Returns a [Center] widget with a [Column] widget as child.
  ///
  /// The [Column] widget is configured with a mainAxisAlignment of
  /// [MainAxisAlignment.center], and a crossAxisAlignment of
  /// [CrossAxisAlignment.center].
  ///
  /// The [Column] widget has three children:
  ///
  /// 1. A [Container] widget with a rounded border with the
  ///    [SenseiConst.outBorderRadius] radius, a color of
  ///    [Theme.of(context).colorScheme.surfaceContainer], and a border of the
  ///    [Theme.of(context).colorScheme.outline] color with an alpha of 0x80.
  ///
  ///    The [Container] widget has an [Image] widget as child, which is
  ///    configured with the [SenseiConst.tadamonAppImage] image, a size of 120
  ///    logical units, and a [BoxFit.cover] fit.
  ///
  /// 2. A [SizedBox] widget with a height of 10 logical units.
  ///
  /// 3. A [Text] widget with the "تطبيق تَضَامُنٌ" text, a style of a
  ///    [TextStyle] with a [fontSize] of 23 logical units, a [fontWeight] of
  ///    [FontWeight.bold], and a color of
  ///    [Theme.of(context).colorScheme.primary].
  ///
  /// 4. A [Padding] widget with a horizontal padding of 30 logical units,
  ///    and a child of a [Text] widget with the copyright text, a style of a
  ///    [TextStyle] with a [fontSize] of 12 logical units, and a color of
  ///    [Theme.of(context).colorScheme.onSurface] with an alpha of 0x80.
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
            "تطبيق تَضَامُنٌ",
            style: TextStyle(
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Text(
              "© 2025${DateTime.now().year > 2025 ? ' - ${DateTime.now().year}' : ''}. جميع الحقوق محفوظة بموجب GNU GENERAL PUBLIC LICENSE الإصدار 3.",
              style: TextStyle(
                fontSize: 12.sp,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
