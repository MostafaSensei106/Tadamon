import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/core/services/pdf_export_services/pdf_export_services.dart';
import 'package:tadamon/core/widgets/app_toast/app_toast.dart';
import 'package:tadamon/features/pages/log_page/data/models/scanned_logs_product_model.dart';
import 'package:tadamon/features/pdf_export/logic/cubit/pdf_export_state.dart';
import 'package:tadamon/features/products_scanner/data/repository/objectbox_repositories.dart';

class PdfExportCubit extends Cubit<PdfExportState> {
  PdfExportCubit() : super(PdfExportInitial());

  Future<void> exportPdf() async {
    List<ScannedLogsProductModel> dataList = ObjectboxRepository()
        .saveLogsTOPDF();
    if (dataList.isEmpty) {
      AppToast.showErrorToast('No data to export');
      emit(PdfExportError());
      return;
    }

    emit(PdfExportLoading());

    try {
      await PdfExportServices().exportPdf(dataList);
      // emit(PdfExportSuccess());
    } catch (e) {
      emit(PdfExportError());
      AppToast.showErrorToast('Error: $e');
    }
  }
}
