import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/config/const/sensei_const.dart';
import '../../../../../core/widgets/app_bar/side_page_app_bar.dart';
import '../../../../../generated/l10n.dart';

class PalestineMapPage extends StatelessWidget {
  const PalestineMapPage({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: SidePageAppBar(
      title: S.of(context).palatineMap,
      useBackButton: true,
    ),
    body: ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(SenseiConst.outBorderRadius.r + 7),
        topRight: Radius.circular(SenseiConst.outBorderRadius.r + 7),
      ),
      child: InteractiveViewer(
        child: Image.asset(
          SenseiConst.palestineMapImage,
          width: 1.sh,
          height: 1.sh,
          fit: BoxFit.cover,
          errorBuilder: (final context, final error, final stackTrace) =>
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: SenseiConst.iconSize,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'حدث خطأ في تحميل الصورة',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
        ),
      ),
    ),
  );
}
