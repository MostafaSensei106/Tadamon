import 'package:flutter/material.dart' hide showBottomSheet;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/pdf_export/logic/cubit/pdf_export_cubit.dart';
import '../../../../features/pdf_export/logic/cubit/pdf_export_state.dart';
import '../../../../features/products_scanner/data/repository/objectbox_repositories.dart';
import '../../../../features/report_products/widgets/report_products_seet_content/report_product_sheet_content.dart';
import '../../../../generated/l10n.dart';
import '../../../config/const/app_enums.dart';
import '../../../routing/routes.dart';
import '../../bottom_sheet/ui/model_bottom_sheet.dart';
import '../../dilog_components/dilog_waiting_component.dart';
import '../../list_tile_components/list_tile_icon_component.dart';

class ActionsSection extends StatelessWidget {
  const ActionsSection({super.key});

  @override
  Widget build(final BuildContext context) => Column(
    children: [
      _buildHowToUse(context),
      _buildReportProduct(context),
      StreamBuilder<int>(
        stream: ObjectboxRepository().getTadamonLogsProductsCount(),
        initialData: 0,
        builder: (final context, final snapshot) {
          final logCount = snapshot.data ?? 0;
          if (logCount > 0) {
            return Column(
              children: [_buildClearLogs(context), _buildExportLogs(context)],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    ],
  );

  Widget _buildHowToUse(final BuildContext context) => ListTileIconComponent(
    groupType: ListTileGroupType.top,
    iconLeading: Icons.question_answer_outlined,
    title: S.of(context).howToUse,
    subtitle: S.of(context).howToUseMassage,
    trailing: Icon(
      Icons.arrow_forward_ios_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    onTap: () {
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.userHelp);
    },
  );

  Widget _buildReportProduct(final BuildContext context) =>
      ListTileIconComponent(
        groupType: ListTileGroupType.bottom,
        iconLeading: Icons.production_quantity_limits_outlined,
        title: S.of(context).reportProduct,
        subtitle: S.of(context).reportProductMassage,
        onTap: () {
          Navigator.pop(context);
          showBottomSheet(
            context,
            'بلغ عن منتج',
            child: const ReportProductSheetContent(),
          );
        },
      );

  Widget _buildClearLogs(final BuildContext context) => ListTileIconComponent(
    iconLeading: Icons.clear_all_rounded,
    title: S.of(context).clearLogs,
    subtitle: S.of(context).clearLogs,
    onTap: () {
      Navigator.of(context).pop();
      ObjectboxRepository().clearTadamonLogsFromLocalDB();
    },
    groupType: ListTileGroupType.top,
  );

  Widget _buildExportLogs(final BuildContext context) => BlocProvider(
    create: (_) => PdfExportCubit(),
    child: BlocConsumer<PdfExportCubit, PdfExportState>(
      listener: (final context, final state) {},
      builder: (final context, final state) {
        if (state is PdfExportLoading) {
          return const DilogWatingComponent(
            icon: Icons.picture_as_pdf_rounded,
            title: 'جاري تصدير السجلات',
            message: 'الرجاء الانتظار',
          );
        }
        return ListTileIconComponent(
          iconLeading: Icons.picture_as_pdf_rounded,
          title: 'تصدير السجلات',
          subtitle: 'تصطير السجلات علي شكل PDF',
          onTap: () {
            Navigator.of(context).pop();
            context.read<PdfExportCubit>().exportPdf();
          },
          groupType: ListTileGroupType.bottom,
        );
      },
    ),
  );
}
