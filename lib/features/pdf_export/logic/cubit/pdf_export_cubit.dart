import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/services/export_services.dart';
import '../../../../core/services/pdf_export_services/pdf_export_services.dart';
import '../../../../core/widgets/app_toast/app_toast.dart';
import '../../../../core/widgets/dilog_components/dilog_ask_user_components.dart';
import '../../../products_scanner/data/repository/objectbox_repositories.dart';
import 'pdf_export_state.dart';

class PdfExportCubit extends Cubit<PdfExportState> {
  PdfExportCubit() : super(const PdfExportInitial()) {
    getInitialData();
  }

  Future<void> getInitialData() async {
    final logCount = await ObjectboxRepository()
        .getTadamonLogsProductsCount()
        .first;
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    final formattedNow = DateFormat('yyyy/MM/dd').format(now);
    final formattedThirtyDaysAgo = DateFormat(
      'yyyy/MM/dd',
    ).format(thirtyDaysAgo);
    final dateRange = '$formattedThirtyDaysAgo - $formattedNow';
    emit(PdfExportInitial(logCount: logCount, dateRange: dateRange));
  }

  Future<void> exportPdf(final BuildContext context) async {
    final dataList = ObjectboxRepository().getAllScannedLogs();
    if (dataList.isEmpty) {
      showErrorToast('No data to export');
      emit(const PdfExportInitial());
      return;
    }

    emit(PdfExportLoading());

    try {
      final pdf = await PdfExportServices().exportPdf(dataList);
      emit(const PdfExportInitial());
      // ignore: use_build_context_synchronously
      await DilogAskUserComponents(
        title: 'تصدير PDF',
        question: 'هل تريد حفظ الملف أم مشاركته؟',
        icon: Icons.picture_as_pdf,
        onYes: () async {
          await PdfExportServices().savePdf(pdf);
        },
        onNo: () async {
          await PdfExportServices().sharePdf(pdf);
        },
        yesText: 'حفظ',
        noText: 'مشاركة',
      ).show(context);
    } catch (e) {
      emit(const PdfExportInitial());
      showErrorToast('Error: $e');
    }
  }

  Future<void> exportCsv(final BuildContext context) async {
    final dataList = ObjectboxRepository().getAllScannedLogs();
    if (dataList.isEmpty) {
      showErrorToast('No data to export');
      emit(const PdfExportInitial());
      return;
    }

    emit(PdfExportLoading());

    try {
      final csv = ExportServices().getCsv(dataList);
      emit(const PdfExportInitial());
      // ignore: use_build_context_synchronously
      await DilogAskUserComponents(
        title: 'تصدير CSV',
        question: 'هل تريد حفظ الملف أم مشاركته؟',
        icon: Icons.table_chart,
        onYes: () async {
          await ExportServices().saveFile(csv, 'csv');
        },
        onNo: () async {
          await ExportServices().shareFile(csv, 'csv');
        },
        yesText: 'حفظ',
        noText: 'مشاركة',
      ).show(context);
    } catch (e) {
      emit(const PdfExportInitial());
      showErrorToast('Error: $e');
    }
  }

  Future<void> exportJson(final BuildContext context) async {
    final dataList = ObjectboxRepository().getAllScannedLogs();
    if (dataList.isEmpty) {
      showErrorToast('No data to export');
      emit(const PdfExportInitial());
      return;
    }

    emit(PdfExportLoading());

    try {
      final json = ExportServices().getJson(dataList);
      emit(const PdfExportInitial());
      // ignore: use_build_context_synchronously
      await DilogAskUserComponents(
        title: 'تصدير JSON',
        question: 'هل تريد حفظ الملف أم مشاركته؟',
        icon: Icons.code,
        onYes: () async {
          await ExportServices().saveFile(json, 'json');
        },
        onNo: () async {
          await ExportServices().shareFile(json, 'json');
        },
        yesText: 'حفظ',
        noText: 'مشاركة',
      ).show(context);
    } catch (e) {
      emit(const PdfExportInitial());
      showErrorToast('Error: $e');
    }
  }
}
