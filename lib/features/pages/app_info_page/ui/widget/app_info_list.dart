import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/widgets/button_component/button_compnent.dart';
import 'package:tadamon/core/widgets/drawer_component/drawer_component.dart';
import 'package:tadamon/features/pages/app_info_page/ui/widget/app_info_title.dart';

class AppInfoList extends StatelessWidget {
  final String appName;
  final String appVersion;
  final String buildNumber;
  final String buildSignature;
  final String packageName;
  final String installerStore;

  const AppInfoList({
    super.key,
    required this.appName,
    required this.appVersion,
    required this.buildNumber,
    required this.buildSignature,
    required this.packageName,
    required this.installerStore,
  });

  /// Copies the app information to the clipboard.
  ///
  /// The information includes:
  ///
  /// - اسم التطبيق (app name)
  /// - إصدار التطبيق (app version)
  /// - رقم البناء (build number)
  /// - توقيع البناء (build signature)
  /// - اسم الحزمة (package name)
  /// - المتجر المثبت (installer store)
  ///
  /// The user will receive a haptic feedback when the information is copied.
  void copyToClipboard() {
    HapticFeedback.vibrate();
    Clipboard.setData(
      ClipboardData(
        text: '''
معلومات تطبيق تضامن:
- اسم التطبيق: $appName
- إصدار التطبيق: $appVersion
- رقم البناء: $buildNumber
- توقيع البناء: $buildSignature
- اسم الحزمة: $packageName
- المتجر المثبت: $installerStore
''',
      ),
    );
  }

  @override

  /// Builds a column of [ListTileComponent] widgets with the given app information,
  ///
  /// The column contains the following widgets in order:
  ///
  /// - A [ListTileComponent] with the app name
  /// - A [ListTileComponent] with the app version
  /// - A [ListTileComponent] with the build number
  /// - A [ListTileComponent] with the build signature
  /// - A [ListTileComponent] with the package name
  /// - A [ListTileComponent] with the installer store
  /// - A [ButtonCompnent] to copy the app information to the clipboard
  ///
  /// The column is wrapped in a [SingleChildScrollView] to make it possible to
  /// scroll the content if it does not fit in the available space.
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppInfoTitle(),
        SizedBox(
          height: 8.h,
        ),
        ListTileComponent(
          leadingIcon: Icons.android_rounded,
          title: 'اسم التطبيق',
          subtitle: appName,
          useDivider: true,
          useGroupTop: true,
        ),
        ListTileComponent(
          leadingIcon: Icons.info_outline,
          title: 'إصدار التطبيق',
          subtitle: appVersion,
          useDivider: true,
          useGroupMiddle: true,
        ),
        ListTileComponent(
          leadingIcon: Icons.build_outlined,
          title: 'رقم البناء',
          subtitle: buildNumber,
          useDivider: true,
          useGroupMiddle: true,
        ),
        ListTileComponent(
          leadingIcon: Icons.code_outlined,
          title: 'توقيع البناء',
          subtitle: buildSignature,
          useDivider: true,
          useGroupMiddle: true,
        ),
        ListTileComponent(
          leadingIcon: Icons.app_registration_outlined,
          title: 'اسم الحزمة',
          subtitle: packageName,
          useDivider: true,
          useGroupMiddle: true,
        ),
        ListTileComponent(
          leadingIcon: Icons.store_outlined,
          title: 'المتجر المثبت',
          subtitle: installerStore,
          useGroupBottom: true,
        ),
        SizedBox(
          width: double.infinity,
          child: ButtonCompnent(
            label: "نسخ معلومات التطبيق",
            icon: Icons.copy_all_rounded,
            useMargin: true,
            onPressed: () => copyToClipboard(),
          ),
        ),
      ],
    );
  }
}
