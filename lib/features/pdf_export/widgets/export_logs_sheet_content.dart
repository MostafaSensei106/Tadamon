import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../logic/cubit/pdf_export_cubit.dart';
import '../logic/cubit/pdf_export_state.dart';
import '../../../core/widgets/button_components/elevated_button_components/elevated_icon_button_component.dart';

class ExportLogsSheetContent extends StatelessWidget {
  const ExportLogsSheetContent({super.key});

  @override
  Widget build(final BuildContext context) =>
      BlocProvider<PdfExportCubit>(
        create: (_) => PdfExportCubit(),
        child: BlocBuilder<PdfExportCubit, PdfExportState>(
          builder: (final context, final state) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).exportLogsSummary,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              if (state is PdfExportLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedIconButtonComponent(
                  icon: const Icon(Icons.picture_as_pdf),
                  label: Text(S.of(context).exportAsPdf),
                  onPressed: () {
                    context.read<PdfExportCubit>().exportPdf();
                  },
                ),
              const SizedBox(height: 10),
              ElevatedIconButtonComponent(
                icon: const Icon(Icons.table_rows),
                label: Text(S.of(context).exportAsCsv),
                onPressed: () {
                  // TODO(Mostafa): Implement CSV export
                },
              ),
              const SizedBox(height: 10),
              ElevatedIconButtonComponent(
                icon: const Icon(Icons.code),
                label: Text(S.of(context).exportAsJson),
                onPressed: () {
                  // TODO(Mostafa): Implement JSON export
                },
              ),
            ],
          ),
        ),
      );
}
