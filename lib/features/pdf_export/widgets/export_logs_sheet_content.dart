import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
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
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text(
                  'جاري التصدير...',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        if (state is PdfExportInitial) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).exportLogsSummary,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  _DataPreviewCard(
                    logCount: state.logCount,
                    dateRange: state.dateRange,
                  ),
                  const SizedBox(height: 24),
                      subtitle: S.of(context).pdfSubtitle,
                        onPressed: () {
                          context.read<PdfExportCubit>().exportPdf();
                        },
                      ),
                      const SizedBox(height: 12),
                      _ExportOptionCard(
                        icon: Icons.table_chart_rounded,
                        iconColor: Colors.green,
                        title: S.of(context).exportAsCsv,
                        subtitle: S.of(context).csvSubtitle,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('قريباً...')),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      _ExportOptionCard(
                        icon: Icons.code_rounded,
                        iconColor: Colors.orange,
                        title: S.of(context).exportAsJson,
                        subtitle: S.of(context).jsonSubtitle,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('قريباً...')),
                          );
                        },
                      ),
                    ],
                  ),
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
  Widget build(final BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue[200]!, width: 1),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline_rounded,
              color: Colors.blue[700],
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).dataPreview,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${S.of(context).totalLogs}: $logCount • ${S.of(context).period}: $dateRange',
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class _ExportOptionCard extends StatelessWidget {
  const _ExportOptionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    ),
  );
}
