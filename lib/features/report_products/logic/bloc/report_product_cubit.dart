import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/date_format_extension.dart';
import '../../../../core/widgets/app_toast/app_toast.dart';
import '../../../products_scanner/logic/barcode_scanner.dart';
import '../services/report_service.dart';
import 'report_product_state.dart';

class ReportProductCubit extends Cubit<ReportProductState> {
  ReportProductCubit() : super(ReportProductInitial());
  bool isFormNotEmpty(final String serialNumber, final String productName) {
    if (serialNumber.isNotEmpty && productName.isNotEmpty) {
      return true;
    }
    return false;
  }

  void validateInputs(final String serialNumber, final String productName) {
    if (isFormNotEmpty(serialNumber, productName)) {
      if (productName.length >= 50) {
        emit(
          ReportProductProductNameIsNotValid(
            'الاسم يجب أن يكون أقل من أو يساوى 50 حرف',
          ),
        );
      } else if (!RegExp(r'^[0-9]{6,13}$').hasMatch(serialNumber)) {
        emit(
          ReportProductSerialNumberIsNotValid(
            'الرقم التسلسلي يجب أن يتكون من 6-13 أرقام',
          ),
        );
      } else {
        emit(ReportProductIsValid());
      }
    } else {
      emit(ReportProductIsNotValid());
    }
  }

  Future<void> scanBarcode(
    final BuildContext context,
    final TextEditingController controller,
  ) async {
    try {
      final scanResult = await BarcodeScanner().scanBarcodeByCamera(context);
      if (scanResult == '-1') return;
      if (scanResult == '-404') return;
      controller.text = scanResult;
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }

  Future<void> submitReport(
    final String serialNumber,
    final String productName,
    final String status,
  ) async {
    emit(ReportProductIsLoading());
    final report = {
      'serialNumber': serialNumber,
      'productName': productName,
      'status': status,
      'timestamp': DateTime.now().formatted,
    };
    try {
      await ReportService().sendProductReport(report);
    } catch (e) {
      AppToast.showErrorToast('حدث خطاء اثناء ارسال التقرير: $e');
    }
  }
}
