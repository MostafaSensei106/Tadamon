import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../core/widgets/app_toast/app_toast.dart';
import '../../../generated/l10n.dart';
import 'barcode_validator.dart';

class BarcodeScanner {
  /// Scans the barcode using the default camera.
  ///
  /// Shows a [SimpleBarcodeScanner] with a custom [BarcodeAppBar] that has a
  /// title of "Scan Barcode" and a back button.
  ///
  /// The [lineColor] is set to red.
  ///
  /// The [cancelButtonText] is set to "Close".
  ///
  /// If the barcode is invalid or not a number, shows an error toast with the
  /// message "The barcode :$barcodeScanRes is invalid, it should be a number
  /// only".
  ///
  /// If the barcode is not read, shows an error toast with the message "No
  /// barcode was read".
  ///
  /// If an error occurs while scanning, shows an error toast with the message
  /// "An error occurred while reading the barcode: ${e.toString()}".
  ///
  /// Returns the scanned barcode as a string.
  ///
  /// If the barcode is not read or is invalid, returns '-1' or '-404'
  /// respectively.
  ///
  /// The [BuildContext] is used to show the error toast.
  ///
  Future<String> scanBarcodeByCamera(final BuildContext context) async {
    try {
      final barcodeScanRes = await SimpleBarcodeScanner.scanBarcode(
        context,
        barcodeAppBar: BarcodeAppBar(
          appBarTitle: S.of(context).scanBarcode,
          centerTitle: true,
          enableBackButton: true,
          backButtonIcon: const Icon(Icons.keyboard_double_arrow_right_rounded),
        ),
        isShowFlashIcon: true,
        delayMillis: 150,
        scanFormat: ScanFormat.ONLY_BARCODE,
        lineColor: '#FF0000',
        cancelButtonText: S.of(context).close,
      );
      if (barcodeScanRes == '-1') {
        showInfoToast('لم يتم قراءة اي باركود');
        return '-1';
      }

      if (!isBarcodeNumber(barcodeScanRes!)) {
        showWarningToast(
          'الباركود :$barcodeScanRes غير صالح، يجب أن يكون رقمًا فقط',
        );
        return '-404';
      }

      return barcodeScanRes;
    } catch (e) {
      'حدث خطأ أثناء قراءة الباركود: ${e.toString()}';
      return '-404';
    }
  }
}
