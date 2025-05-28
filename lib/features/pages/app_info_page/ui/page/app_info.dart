import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tadamon/core/widgets/app_bar/side_page_app_bar.dart';

class AppInfo extends StatefulWidget {
  const AppInfo({super.key});

  @override
  State<AppInfo> createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  String appVersion = '';
  String buildNumber = '';

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        appVersion = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      });
    } on MissingPluginException catch (e) {
      debugPrint('PackageInfoPlus error: $e');
      setState(() {
        appVersion = ' PackageInfoPlus error';
        buildNumber = ' PackageInfoPlus error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const SidePageAppBar(title: 'معلومات التطبيق', useBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('الاصدار: $appVersion'),
            Text('رقم التحديث: $buildNumber'),
          ],
        ),
      ),
    );
  }
}
