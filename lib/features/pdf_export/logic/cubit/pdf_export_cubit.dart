import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/pdf_export_services/pdf_export_services.dart';
import '../../../../core/widgets/app_toast/app_toast.dart';
import '../../../products_scanner/data/repository/objectbox_repositories.dart';
import 'pdf_export_state.dart';

class PdfExportCubit extends Cubit<PdfExportState> {
  PdfExportCubit() : super(PdfExportInitial());

  Future<void> exportPdf() async {
    final dataList = ObjectboxRepository().saveLogsTOPDF();
    if (dataList.isEmpty) {
      showErrorToast('No data to export');
      emit(PdfExportError());
      return;
    }

    emit(PdfExportLoading());

    try {
      await PdfExportServices().exportPdf(dataList);
      // emit(PdfExportSuccess());
    } catch (e) {
      emit(PdfExportError());
      showErrorToast('Error: $e');
    }
  }
}
