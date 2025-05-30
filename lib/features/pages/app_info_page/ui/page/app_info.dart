import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/app_bar/side_page_app_bar.dart';
import 'package:tadamon/features/pages/app_info_page/ui/widget/app_info_list.dart';

class AppInfo extends StatefulWidget {
  const AppInfo({super.key});

  @override
  State<AppInfo> createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  String _appVersion = '';
  String _buildNumber = '';
  String _appName = '';
  String _packageName = '';
  String _installerStore = '';
  String _buildSignature = '';

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();

      setState(() {
        _appVersion = "${packageInfo.version}-V";
        _buildNumber = packageInfo.buildNumber;
        _appName = packageInfo.appName;
        _packageName = packageInfo.packageName;
        _installerStore = packageInfo.installerStore ?? 'غير معروف';
        _buildSignature = packageInfo.buildSignature;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading app info: $e');
      setState(() {
        _appVersion = 'خطأ في تحميل البيانات';
        _buildNumber = 'خطأ في تحميل البيانات';
        _appName = 'خطأ في تحميل البيانات';
        _packageName = 'خطأ في تحميل البيانات';
        _installerStore = 'خطأ في تحميل البيانات';
        _buildSignature = 'خطأ في تحميل البيانات';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SidePageAppBar(
        title: 'معلومات التطبيق',
        useBackButton: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: SenseiConst.padding.w),
              child: AppInfoList(
                appName: _appName,
                appVersion: _appVersion,
                buildNumber: _buildNumber,
                buildSignature: _buildSignature,
                packageName: _packageName,
                installerStore: _installerStore,
              ),
            ),
    );
  }
}
