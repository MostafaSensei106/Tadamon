import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:share_plus/share_plus.dart';

import '../../features/pages/log_page/data/models/scanned_logs_product_model.dart';
import '../extensions/date_format_extension.dart';
import '../widgets/app_toast/app_toast.dart';
import 'share_Services/share_services.dart';

class ExportServices {
  String getCsv(final List<ScannedLogsProductModel> logs) {
    final buffer = StringBuffer()
      ..writeln(
        'name,serialNumber,manufacture,category,trusted,onError,scannedAt',
      );

    for (final log in logs) {
      buffer.writeln(
        '${log.name},${log.serialNumber},${log.manufacture},${log.category},${log.trusted},${log.onError},${log.scannedAt}',
      );
    }
    return buffer.toString();
  }

  String getJson(final List<ScannedLogsProductModel> logs) {
    final jsonList = logs.map((final log) => log.toMap()).toList();
    return jsonEncode(jsonList);
  }

  Future<void> saveFile(final String content, final String extension) async {
    try {
      final dir = await FilePicker.platform.getDirectoryPath();
      if (dir != null) {
        final fileName = 'Tadamon_Logs_${DateTime.now().formatted}';
        final file = File('$dir/$fileName.$extension');
        await file.writeAsString(content);
        await OpenFile.open(file.path);
        showSuccessToast('تم حفظ الملف بنجاح');
      }
    } catch (e) {
      showErrorToast('Failed to save the file');
    }
  }

  Future<void> shareFile(final String content, final String extension) async {
    try {
      final dir = await path.getTemporaryDirectory();
      final fileName = 'Tadamon_Logs_${DateTime.now().formatted}';
      final file = File('${dir.path}/$fileName.$extension');
      await file.writeAsString(content);
      ShareServices.shareFile(XFile(file.path));
    } catch (e) {
      showErrorToast('Failed to share the file');
    }
  }
}
