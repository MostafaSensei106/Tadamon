import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/services/export_services.dart';
import '../../../../core/services/pdf_export_services/pdf_export_services.dart';
import '../../../../core/widgets/app_toast/app_toast.dart';
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

  Future<void> exportPdf() async {
    final dataList = ObjectboxRepository().getAllScannedLogs();
    if (dataList.isEmpty) {
      showErrorToast('No data to export');
      emit(const PdfExportInitial());
      return;
    }

    emit(PdfExportLoading());

    try {
      await PdfExportServices().exportPdf(dataList);
      emit(const PdfExportInitial());
    } catch (e) {
      emit(const PdfExportInitial());
      showErrorToast('Error: $e');
    }
  }

  Future<void> exportCsv() async {
    final dataList = ObjectboxRepository().getAllScannedLogs();
    if (dataList.isEmpty) {
      showErrorToast('No data to export');
      emit(const PdfExportInitial());
      return;
    }

    emit(PdfExportLoading());

    try {
      await ExportServices().exportToCsv(dataList);
      emit(const PdfExportInitial());
    } catch (e) {
      emit(const PdfExportInitial());
      showErrorToast('Error: $e');
    }
  }

  Future<void> exportJson() async {
    final dataList = ObjectboxRepository().getAllScannedLogs();
    if (dataList.isEmpty) {
      showErrorToast('No data to export');
      emit(const PdfExportInitial());
      return;
    }

    emit(PdfExportLoading());

    try {
      await ExportServices().exportToJson(dataList);
      emit(const PdfExportInitial());
    } catch (e) {
      emit(const PdfExportInitial());
      showErrorToast('Error: $e');
    }
  }
}
