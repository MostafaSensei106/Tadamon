import 'package:flutter/material.dart' show Icons, IconButton;
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:flutter/widgets.dart'
    show
        StatelessWidget,
        BuildContext,
        Widget,
        NeverScrollableScrollPhysics,
        Icon,
        ListView;
import '../../../../core/config/const/app_enums.dart' show ListTileGroupType;
import '../../../../core/widgets/list_tile_components/list_tile_icon_component.dart'
    show ListTileIconComponent;
import '../../data/models/product_model.dart' show ProductModel;

class ProductListView extends StatelessWidget {
  const ProductListView({required this.product, super.key});
  final ProductModel product;

  @override
  Widget build(final BuildContext context) => ListView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    children: [
      ListTileIconComponent(
        useinBorderRadius: true,
        icon: Icons.qr_code_rounded,
        title: 'الرقم التسلسلي',
        subtitle: product.serialNumber,
        groupType: ListTileGroupType.top,
        trailing: IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () => {
            Clipboard.setData(ClipboardData(text: product.serialNumber)),
          },
        ),
      ),
      ListTileIconComponent(
        icon: Icons.label_outline_rounded,
        title: 'إسم المنتج',
        subtitle: product.name,
        groupType: ListTileGroupType.middle,
      ),
      ListTileIconComponent(
        icon: Icons.business_rounded,
        title: 'المصنع',
        subtitle: product.manufacture,
        groupType: ListTileGroupType.middle,
      ),
      ListTileIconComponent(
        icon: Icons.category_outlined,
        title: 'التصنيف',
        subtitle: product.category,
        groupType: ListTileGroupType.middle,
      ),
      ListTileIconComponent(
        useinBorderRadius: true,
        icon: Icons.handshake_outlined,
        title: 'الحالة',
        subtitle: product.onError == 'Product not found'
            ? 'المنتج غير موجود'
            : product.trusted
            ? 'مؤمن'
            : 'غير مؤمن',
        groupType: ListTileGroupType.bottom,
      ),
    ],
  );
}
