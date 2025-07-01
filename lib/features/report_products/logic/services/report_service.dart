import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/controller/network_controller/network_controller.dart';
import '../../../../core/widgets/app_toast/app_toast.dart';
import '../../../products_scanner/data/repository/fire_store_repositories.dart';

class ReportService {
  static late SharedPreferences pref;

  static Future<void> initializePreferences() async {
    pref = await SharedPreferences.getInstance();
  }

  Future<void> sendProductReport(final Map<String, dynamic> productReport) async {
    if (await NetworkController().checkConnection()) {
      try {
        await FireStoreRepository().sendReportToBackEnd(productReport);
        AppToast.showSuccessToast('لقد تلقينا بلاغك');
      } catch (e) {
        AppToast.showErrorToast('حث خطاء');
      }
    } else {
      AppToast.showSimpleToast(
        'لا يوجد انترنت. سيتم إرسال البلاغ تلقائيًا لاحقًا.',
      );
      await _saveReportLocally(productReport);
    }
  }

  Future<void> _saveReportLocally(final Map<String, dynamic> productReport) async {
    final localReports = pref.getStringList('localReports') ?? [];
    localReports.add(jsonEncode(productReport));
    await pref.setStringList('localReports', localReports);
  }

  static Future<List<Map<String, dynamic>>> _getLocalReports() async {
    final localReports = pref.getStringList('localReports') ?? [];
    return localReports
        .map((final report) => jsonDecode(report) as Map<String, dynamic>)
        .toList();
  }

  static Future<void> resendPendingReports() async {
    final localReports = await _getLocalReports();
    for (final report in localReports) {
      try {
        await FireStoreRepository().sendReportToBackEnd(report);
        await _clearLocalReports(report);
        AppToast.showSimpleToast('تم إرسال بلاغ معلق');
      } catch (e) {
        AppToast.showErrorToast(e.toString());
      }
    }
  }

  static Future<void> _clearLocalReports(final Map<String, dynamic> report) async {
    final localReports = pref.getStringList('localReports') ?? [];
    localReports.remove(jsonEncode(report));
    await pref.setStringList('localReports', localReports);
  }
}
