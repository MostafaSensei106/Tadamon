import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tadamon/core/widgets/button_component/button_compnent.dart';
import 'package:tadamon/core/widgets/drawer_component/drawer_component.dart';

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
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerComponent(
          leadingIcon: Icons.android_rounded,
          title: 'اسم التطبيق',
          subtitle: appName,
          useDivider: true,
          useGroupTop: true,
        ),
        DrawerComponent(
          leadingIcon: Icons.info_outline,
          title: 'إصدار التطبيق',
          subtitle: appVersion,
          useDivider: true,
          useGroupMiddle: true,
        ),
        DrawerComponent(
          leadingIcon: Icons.build_outlined,
          title: 'رقم البناء',
          subtitle: buildNumber,
          useDivider: true,
          useGroupMiddle: true,
        ),
        DrawerComponent(
          leadingIcon: Icons.code_outlined,
          title: 'توقيع البناء',
          subtitle: buildSignature,
          useDivider: true,
          useGroupMiddle: true,
        ),
        DrawerComponent(
          leadingIcon: Icons.app_registration_outlined,
          title: 'اسم الحزمة',
          subtitle: packageName,
          useDivider: true,
          useGroupMiddle: true,
        ),
        DrawerComponent(
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
