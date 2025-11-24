import 'dart:io' show File;

import 'package:flutter/services.dart' show rootBundle;
import 'package:open_file/open_file.dart' show OpenFile;
import 'package:path_provider/path_provider.dart' as path;
import 'package:pdf/widgets.dart' as pw;

import '../../../features/pages/log_page/data/models/scanned_logs_product_model.dart'
    show ScannedLogsProductModel;
import '../../config/const/sensei_const.dart' show SenseiConst;
import '../../extensions/date_format_extension.dart';
import '../../widgets/app_toast/app_toast.dart'
    show showSuccessToast, showErrorToast;

class PdfExportServices {
  /// Exports the given list of [ScannedLogsProductModel] to a pdf file named
  /// "Tadamon_Logs.pdf" in the app's document directory, and
  /// opens it afterwards.
  ///
  /// The pdf file will contain a table with the headers as the keys of the
  /// first element of the list, and the values as the rows of the table.
  ///
  /// If the operation fails, a toast error message will be shown.
  Future<void> exportPdf(final List<ScannedLogsProductModel> dataList) async {
    try {
      final fileName = 'Tadamon_Logs_${DateTime.now().formatted}';
      final pdf = pw.Document();
      final headers = dataList.first.toMap().keys.toList();
      final data = dataList
          .map((final item) => item.toMap().values.toList())
          .toList();

      final imageBytes = (await rootBundle.load(
        SenseiConst.tadamonAppImage,
      )).buffer.asUint8List();
      final pw.ImageProvider image = pw.MemoryImage(imageBytes);

      final fontData =
          await rootBundle.load('assets/fonts/ar/Tajawal-Regular.ttf');
      final ttf = pw.Font.ttf(fontData);

      pdf.addPage(
        pw.Page(
          theme: pw.ThemeData.withFont(
            base: ttf,
          ),
          build: (final context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(child: pw.Image(image, width: 150, height: 150)),
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Text(
                  'تقرير السجلات',
                  style: pw.TextStyle(
                    fontSize: 26,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: headers,
                headerStyle: const pw.TextStyle(fontSize: 14),
                headerDecoration: const pw.BoxDecoration(),
                data: data
                    .map(
                      (final row) =>
                          row.map((final cell) => cell.toString()).toList(),
                    )
                    .toList(),
                border: pw.TableBorder.symmetric(),
                cellAlignment: pw.Alignment.center,
                cellStyle: const pw.TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      );

      final dir = await path.getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileName.pdf');
      await file.writeAsBytes(await pdf.save());
      await OpenFile.open(file.path);
      showSuccessToast('تم حفظ الملف بنجاح');
    } catch (e) {
      showErrorToast('Failed to generate the pdf');
    }
  }
}
