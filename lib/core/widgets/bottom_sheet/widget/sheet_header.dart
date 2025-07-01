import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/const/sensei_const.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({required this.titile, super.key});
  final String titile;

  @override
  ///
  /// A widget that displays a header in a bottom sheet.
  ///
  /// The header is a horizontal line with a title below it.
  ///
  /// The color of the line is the primary color with a dim (50%) opacity.
  ///
  /// The title is displayed in the [Theme.of(context).textTheme.titleMedium]
  /// style.
  ///
  /// There is a 6 logical pixel gap between the title and the line.
  ///
  /// The header is centered horizontally.
  ///
  Widget build(final BuildContext context) => Center(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: SenseiConst.margin.h),
            width: 80.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryFixedDim,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Text(titile, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: 6.h),
        ],
      ),
    );
}
