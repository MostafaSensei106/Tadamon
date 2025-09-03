import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/config/const/shared_preferences_keys.dart';
import '../../../../core/controller/network_controller/network_controller.dart';
import '../../../../core/shared_preferences_global/shared_preferences_global.dart';
import '../../../../core/widgets/app_toast/app_toast.dart';
import '../../../products_scanner/data/repository/fire_store_repositories.dart';

class ReportService {
  static late SharedPreferences pref;

  static Future<void> initializePreferences() async {
    pref = await SharedPreferences.getInstance();
  }

  Future<void> sendProductReport(
    final Map<String, dynamic> productReport,
  ) async {
    if (await NetworkController().checkConnection()) {
      try {
        await FireStoreRepository().sendReportToBackEnd(productReport);
        showSuccessToast('لقد تلقينا بلاغك');
      } catch (e) {
        showErrorToast('حث خطاء');
      }
    } else {
      showSimpleToast('لا يوجد انترنت. سيتم إرسال البلاغ تلقائيًا لاحقًا.');
      await _saveReportLocally(productReport);
    }
  }

  Future<void> _saveReportLocally(
    final Map<String, dynamic> productReport,
  ) async {
    final localReports = SharedPreferencesGlobal.getValue<List<String>>(
      SharedPreferencesKeys.localReports,
    )..add(jsonEncode(productReport));
    await SharedPreferencesGlobal.setValue<List<String>>(
      SharedPreferencesKeys.localReports,
      localReports,
    );
  }

  static Future<List<Map<String, dynamic>>> _getLocalReports() async {
    final localReports = SharedPreferencesGlobal.getValue<List<String>>(
      SharedPreferencesKeys.localReports,
    );
    return localReports
        .map((final report) => jsonDecode(report) as Map<String, dynamic>)
        .toList();
  }

  static Future<void> resendPendingReports() async {
    final localReports = await _getLocalReports();
    for (final report in localReports) {
      try {
        await FireStoreRepository().sendReportToBackEnd(report);
        await _clearLocalReports();
        showSimpleToast('تم إرسال بلاغ معلق');
      } catch (e) {
        showErrorToast(e.toString());
      }
    }
  }

  static Future<void> _clearLocalReports() async {
    await SharedPreferencesGlobal.clearDataInKey(
      SharedPreferencesKeys.localReports,
    );
  }
}
