import 'dart:io';

import 'package:dartarabic/dartarabic.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:open_file/open_file.dart' show OpenFile;
import 'package:path_provider/path_provider.dart' as path;
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../../../features/pages/log_page/data/models/scanned_logs_product_model.dart'
    show ScannedLogsProductModel;
import '../../config/const/sensei_const.dart' show SenseiConst;
import '../../extensions/date_format_extension.dart';
import '../../widgets/app_toast/app_toast.dart'
    show showSuccessToast, showErrorToast;
import '../share_Services/share_services.dart';

class PdfExportServices {
  String wrapWithUnicodeBidi(final String text) => '\u202B$text\u202C';

  Future<pw.Document> exportPdf(
    final List<ScannedLogsProductModel> dataList,
  ) async {
    final pdf = pw.Document();
    final headers = dataList.first
        .toMap()
        .keys
        .map(
          (final key) => wrapWithUnicodeBidi(DartArabic.normalizeLetters(key)),
        )
        .toList();
    final data = dataList
        .map(
          (final item) => item
              .toMap()
              .values
              .map(
                (final value) => wrapWithUnicodeBidi(
                  DartArabic.normalizeLetters(value.toString()),
                ),
              )
              .toList(),
        )
        .toList();

    final imageBytes = (await rootBundle.load(
      SenseiConst.tadamonAppImage,
    )).buffer.asUint8List();
    final pw.ImageProvider image = pw.MemoryImage(imageBytes);

    final fontData = await rootBundle.load(
      'assets/fonts/ar/Tajawal-Regular.ttf',
    );
    final ttf = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(base: ttf),
        build: (final context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(child: pw.Image(image, width: 150, height: 150)),
            pw.SizedBox(height: 20),
            pw.Center(
              child: pw.Text(
                wrapWithUnicodeBidi(
                  DartArabic.normalizeLetters('تقرير السجلات'),
                ),
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
              data: data,
              border: pw.TableBorder.symmetric(),
              cellAlignment: pw.Alignment.center,
              cellStyle: const pw.TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
    return pdf;
  }

  Future<void> savePdf(final pw.Document pdf) async {
    try {
      final dir = await FilePicker.platform.getDirectoryPath();
      if (dir != null) {
        final fileName = 'Tadamon_Logs_${DateTime.now().formatted}';
        final file = File('$dir/$fileName.pdf');
        await file.writeAsBytes(await pdf.save());
        await OpenFile.open(file.path);
        showSuccessToast('تم حفظ الملف بنجاح');
      }
    } catch (e) {
      showErrorToast('Failed to save the pdf');
    }
  }

  Future<void> sharePdf(final pw.Document pdf) async {
    try {
      final dir = await path.getTemporaryDirectory();
      final fileName = 'Tadamon_Logs_${DateTime.now().formatted}';
      final file = File('${dir.path}/$fileName.pdf');
      await file.writeAsBytes(await pdf.save());
      ShareServices.shareFile(XFile(file.path));
    } catch (e) {
      showErrorToast('Failed to share the pdf');
    }
  }
}
