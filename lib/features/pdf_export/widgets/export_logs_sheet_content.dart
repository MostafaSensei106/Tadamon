import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/const/app_enums.dart';
import '../../../core/config/const/sensei_const.dart';
import '../../../core/widgets/list_tile_components/list_tile_icon_component.dart';
import '../../../l10n/app_localizations.dart';
import '../logic/cubit/pdf_export_cubit.dart';
import '../logic/cubit/pdf_export_state.dart';

class ExportLogsSheetContent extends StatelessWidget {
  const ExportLogsSheetContent({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider<PdfExportCubit>(
    create: (final context) => PdfExportCubit(),
    child: BlocBuilder<PdfExportCubit, PdfExportState>(
      builder: (final context, final state) {
        if (state is PdfExportLoading) {
          return const SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: SenseiConst.padding,
              children: [CircularProgressIndicator(), Text('جاري التصدير...')],
            ),
          );
        }

        if (state is PdfExportInitial) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SenseiConst.padding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _DataPreviewCard(
                  logCount: state.logCount,
                  dateRange: state.dateRange,
                ),
                ListTileIconComponent(
                  icon: Icons.picture_as_pdf_rounded,
                  title: AppLocalizations.of(context)!.exportAsPdf,
                  subtitle: AppLocalizations.of(context)!.pdfSubtitle,
                  onTap: () {
                    context.read<PdfExportCubit>().exportPdf();
                  },
                  useinBorderRadius: true,
                  groupType: ListTileGroupType.top,
                ),
                ListTileIconComponent(
                  icon: Icons.table_chart_rounded,
                  title: AppLocalizations.of(context)!.exportAsCsv,
                  subtitle: AppLocalizations.of(context)!.csvSubtitle,
                  onTap: () {
                    context.read<PdfExportCubit>().exportCsv();
                  },
                  groupType: ListTileGroupType.middle,
                ),
                ListTileIconComponent(
                  icon: Icons.code_rounded,
                  title: AppLocalizations.of(context)!.exportAsJson,
                  subtitle: AppLocalizations.of(context)!.jsonSubtitle,
                  onTap: () {
                    context.read<PdfExportCubit>().exportJson();
                  },
                  useinBorderRadius: true,
                  groupType: ListTileGroupType.bottom,
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    ),
  );
}

class _DataPreviewCard extends StatelessWidget {
  const _DataPreviewCard({required this.logCount, required this.dateRange});

  final int logCount;
  final String dateRange;

  @override
  Widget build(final BuildContext context) => ListTileIconComponent(
    title: AppLocalizations.of(context)!.dataPreview,
    useinBorderRadius: true,
    groupType: ListTileGroupType.single,
    icon: Icons.info_outline_rounded,
    subtitle:
        '${AppLocalizations.of(context)!.totalLogs}: $logCount • ${AppLocalizations.of(context)!.period}: $dateRange',
  );
}
