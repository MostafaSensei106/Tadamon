import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/config/const/app_enums.dart' show ListTileGroupType;
import '../../../../../core/config/const/sensei_const.dart';
import '../../../../../core/config/fonts/fonts.dart';
import '../../../../../core/extensions/date_format_extension.dart';
import '../../../../../core/widgets/list_tile_components/list_tile_icon_component.dart';
import '../../data/models/scanned_logs_product_model.dart';

class ProductLogsExpansionTileComponent extends StatelessWidget {
  const ProductLogsExpansionTileComponent({required this.product, super.key});
  final ScannedLogsProductModel product;
  @override
  Widget build(final BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
    ),
    child: ExpansionTile(
      leading: product.trusted
          ? Container(
              padding: EdgeInsets.all(SenseiConst.padding.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  SenseiConst.inBorderRadius.r,
                ),
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
              ),
              child: const Icon(
                Icons.check_circle_outline_outlined,
                size: SenseiConst.iconSize,
              ),
            )
          : Container(
              padding: EdgeInsets.all(SenseiConst.padding.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  SenseiConst.inBorderRadius.r,
                ),
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
              ),
              child: const Icon(
                Icons.block_rounded,
                size: SenseiConst.iconSize,
              ),
            ),
      title: Text(product.name),
      subtitle: Text(
        product.serialNumber,
        style: AppTextStyle(context).subtitle,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withAlpha(0x80),
        ),
      ),
      children: [
        ListTileIconComponent(
          iconLeading: Icons.qr_code_rounded,
          title: 'الرقم التسلسلي',
          subtitle: product.serialNumber,
          trailing: IconButton(
            onPressed: () =>
                Clipboard.setData(ClipboardData(text: product.serialNumber)),
            icon: const Icon(Icons.copy),
          ),
          groupType: ListTileGroupType.top,
        ),
        ListTileIconComponent(
          iconLeading: Icons.label_outline_rounded,
          title: 'اسم المنتج',
          subtitle: product.name,
          groupType: ListTileGroupType.middle,
        ),
        ListTileIconComponent(
          iconLeading: Icons.business_rounded,
          title: 'الشركة المصنعة',
          subtitle: product.manufacture,
          groupType: ListTileGroupType.middle,
        ),
        ListTileIconComponent(
          iconLeading: Icons.category_outlined,
          title: 'التصنيف',
          subtitle: product.category,
          groupType: ListTileGroupType.middle,
        ),
        ListTileIconComponent(
          iconLeading: Icons.handshake_outlined,
          title: 'الحالة',
          subtitle: product.onError == 'Product not found'
              ? 'المنتج غير موجود'
              : product.trusted
              ? 'مؤمن'
              : 'غير مؤمن',
          groupType: ListTileGroupType.middle,
        ),
        ListTileIconComponent(
          iconLeading: Icons.date_range_outlined,
          title: 'التاريخ',
          subtitle: product.scannedAt.formatted,
          groupType: ListTileGroupType.bottom,
        ),
      ],
    ),
  );
}
