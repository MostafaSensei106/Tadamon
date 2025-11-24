import 'package:flutter/material.dart' hide showBottomSheet;

import '../../../../features/pdf_export/widgets/export_logs_sheet_content.dart';
import '../../../../features/products_scanner/data/repository/objectbox_repositories.dart';
import '../../../../features/report_products/widgets/report_products_seet_content/report_product_sheet_content.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../config/const/app_enums.dart';
import '../../../routing/routes.dart';
import '../../bottom_sheet/ui/model_bottom_sheet.dart';
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
    icon: Icons.question_answer_outlined,
    title: AppLocalizations.of(context)!.howToUse,
    subtitle: AppLocalizations.of(context)!.howToUseMassage,
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
        icon: Icons.production_quantity_limits_outlined,
        title: AppLocalizations.of(context)!.reportProduct,
        subtitle: AppLocalizations.of(context)!.reportProductMassage,
        onTap: () {
          Navigator.pop(context);
          showBottomSheet(
            context,
            AppLocalizations.of(context)!.reportProduct,
            child: const ReportProductSheetContent(),
          );
        },
      );

  Widget _buildClearLogs(final BuildContext context) => ListTileIconComponent(
    icon: Icons.clear_all_rounded,
    title: AppLocalizations.of(context)!.clearLogs,
    subtitle: AppLocalizations.of(context)!.clearLogsMassage,
    onTap: () {
      Navigator.of(context).pop();
      ObjectboxRepository().clearTadamonLogsFromLocalDB();
    },
    groupType: ListTileGroupType.top,
  );

  Widget _buildExportLogs(final BuildContext context) => ListTileIconComponent(
    icon: Icons.picture_as_pdf_rounded,
    title: AppLocalizations.of(context)!.exportLogs,
    subtitle: AppLocalizations.of(context)!.exportLogsSummary,
    onTap: () {
      Navigator.of(context).pop();
      showBottomSheet(
        context,
        AppLocalizations.of(context)!.exportLogs,
        child: const ExportLogsSheetContent(),
      );
    },
    groupType: ListTileGroupType.bottom,
  );
}
