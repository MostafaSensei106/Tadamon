import 'dart:convert';
import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart' as path;

import '../../features/pages/log_page/data/models/scanned_logs_product_model.dart';
import '../extensions/date_format_extension.dart';
import '../widgets/app_toast/app_toast.dart';

class ExportServices {
  Future<void> exportToCsv(final List<ScannedLogsProductModel> logs) async {
    try {
      final buffer = StringBuffer()
        ..writeln(
          'name,serialNumber,manufacture,category,trusted,onError,scannedAt',
        );

      for (final log in logs) {
        buffer.writeln(
          '${log.name},${log.serialNumber},${log.manufacture},${log.category},${log.trusted},${log.onError},${log.scannedAt}',
        );
      }

      final dir = await path.getApplicationDocumentsDirectory();
      final file = File(
        '${dir.path}/Tadamon_Logs_${DateTime.now().formatted}.csv',
      );
      await file.writeAsString(buffer.toString());
      await OpenFile.open(file.path);
      showSuccessToast('Exported to CSV');
    } catch (e) {
      showErrorToast('Failed to export to CSV');
    }
  }

  Future<void> exportToJson(final List<ScannedLogsProductModel> logs) async {
    try {
      final jsonList = logs.map((final log) => log.toMap()).toList();
      final jsonString = jsonEncode(jsonList);

      final dir = await path.getApplicationDocumentsDirectory();
      final file = File(
        '${dir.path}/Tadamon_Logs_${DateTime.now().formatted}.json',
      );
      await file.writeAsString(jsonString);
      await OpenFile.open(file.path);
      showSuccessToast('Exported to JSON');
    } catch (e) {
      showErrorToast('Failed to export to JSON');
    }
  }
}
