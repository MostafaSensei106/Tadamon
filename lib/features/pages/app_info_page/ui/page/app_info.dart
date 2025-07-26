import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../../core/config/const/sensei_const.dart';
import '../../../../../core/widgets/app_bar/side_page_app_bar.dart';
import '../widget/app_info_list.dart';

class AppInfo extends StatefulWidget {
  const AppInfo({super.key});

  @override
  State<AppInfo> createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  String _appVersion = '';
  String _appName = '';
  String _packageName = '';
  String _installerStore = '';

  bool _isLoading = true;

  @override
  /// Initializes the state of the widget.
  ///
  /// This function is called when the widget is first inserted into the tree.
  ///
  /// It calls [super.initState] and then calls [_loadAppInfo] to load the app's
  /// information and update the state with the loaded values.
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  /// Loads the app's information from the device.
  ///
  /// This function is used in [initState] to load the app's information when the
  /// widget is first initialized.
  ///
  /// If the app's information is successfully loaded, it updates the state with
  /// the loaded values. If there is an error while loading the app's
  /// information, it updates the state with an error message.
  ///
  /// The app's information includes the app's name, version, build number,
  /// package name, installer store, and build signature.
  Future<void> _loadAppInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();

      setState(() {
        _appVersion = '${packageInfo.version} (${packageInfo.buildNumber})';
        _appName = packageInfo.appName;
        _packageName = packageInfo.packageName;
        _installerStore = packageInfo.installerStore ?? 'غير معروف';
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading app info: $e');
      setState(() {
        _appVersion = 'خطأ في تحميل البيانات';
        _appName = 'خطأ في تحميل البيانات';
        _packageName = 'خطأ في تحميل البيانات';
        _installerStore = 'خطأ في تحميل البيانات';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: const SidePageAppBar(title: 'معلومات التطبيق', useBackButton: true),
    body: _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: EdgeInsets.only(
              left: SenseiConst.padding.w,
              right: SenseiConst.padding.w,
              bottom: SenseiConst.padding.h,
            ),
            child: AppInfoList(
              appName: _appName,
              appVersion: _appVersion,
              packageName: _packageName,
              installerStore: _installerStore,
            ),
          ),
  );
}
