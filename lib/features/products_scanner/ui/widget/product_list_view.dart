
import 'package:flutter/material.dart' show Icons, IconButton;
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:flutter/widgets.dart' show StatelessWidget, BuildContext, Widget, NeverScrollableScrollPhysics, Icon, SizedBox, ListView;
import 'package:tadamon/core/config/const/app_enums.dart' show ListTileGroupType;
import 'package:tadamon/core/widgets/button_component/button_compnent.dart' show ButtonCompnent;
import 'package:tadamon/core/widgets/drawer_component/drawer_component.dart' show ListTileIconComponent;
import 'package:tadamon/features/products_scanner/data/models/product_model.dart' show ProductModel;


class ProductListView extends StatelessWidget {
  final ProductModel product;

  const ProductListView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ListTileIconComponent(
          useinBorderRadius: true,
          leading: Icons.qr_code_rounded,
          title: "الرقم التسلسلي",
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
          leading: Icons.label_outline_rounded,
          title: "إسم المنتج",
          subtitle: product.name, groupType: ListTileGroupType.middle,
        ),
        ListTileIconComponent(
          leading: Icons.business_rounded,
          title: "المصنع",
          subtitle: product.manufacture, groupType: ListTileGroupType.middle,
        ),
        ListTileIconComponent(

          leading: Icons.category_outlined,
          title: "التصنيف",
          subtitle: product.category, groupType: ListTileGroupType.middle,
        ),
        ListTileIconComponent(
          useinBorderRadius: true,
          leading: Icons.handshake_outlined,
          title: "الحالة",
          subtitle: product.onError == "Product not found"
              ? "المنتج غير موجود"
              : product.trusted
              ? "مؤمن"
              : "غير مؤمن", groupType: 
              ListTileGroupType.bottom,
        ),
        if (!product.trusted)
          SizedBox(
            width: double.infinity,
            child: ButtonCompnent(
              label: '',
              icon: Icons.report_problem_outlined,
              onPressed: () {},
            ),
          ),
      ],
    );
  }
}