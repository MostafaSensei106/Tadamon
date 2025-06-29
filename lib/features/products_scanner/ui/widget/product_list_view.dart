import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tadamon/core/widgets/button_component/button_compnent.dart';
import 'package:tadamon/core/widgets/drawer_component/drawer_component.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model.dart';

class ProductListView extends StatelessWidget {
  final ProductModel product;

  const ProductListView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ListTileComponent(
          useGroupTop: true,
          useDivider: true,
          useinBorderRadius: true,
          leadingIcon: Icons.qr_code_rounded,
          title: "الرقم التسلسلي",
          subtitle: product.serialNumber,
          trailingWidget: IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () => {
              HapticFeedback.vibrate(),
              Clipboard.setData(ClipboardData(text: product.serialNumber)),
            },
          ),
        ),
        ListTileComponent(
          useGroupMiddle: true,
          useDivider: true,
          leadingIcon: Icons.label_outline_rounded,
          title: "إسم المنتج",
          subtitle: product.name,
        ),
        ListTileComponent(
          useGroupMiddle: true,
          useDivider: true,
          leadingIcon: Icons.business_rounded,
          title: "المصنع",
          subtitle: product.manufacture,
        ),
        ListTileComponent(
          useGroupMiddle: true,
          useDivider: true,
          leadingIcon: Icons.category_outlined,
          title: "التصنيف",
          subtitle: product.category,
        ),
        ListTileComponent(
          useGroupBottom: true,
          useinBorderRadius: true,
          leadingIcon: Icons.handshake_outlined,
          title: "الحالة",
          subtitle: product.onError == "Product not found"
              ? "المنتج غير موجود"
              : product.trusted
              ? "مؤمن"
              : "غير مؤمن",
        ),
        if (!product.trusted)
          ButtonCompnent(
            label: '',
            icon: Icons.report_problem_outlined,
            onPressed: () {},
          ),
      ],
    );
  }
}
