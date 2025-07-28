import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/config/const/app_enums.dart' show ListTileGroupType;
import '../../../../../core/widgets/button_component/button_compnent.dart';
import '../../../../../core/widgets/list_tile_components/list_tile_icon_component.dart';
import 'app_info_title.dart';

class AppInfoList extends StatefulWidget {
  const AppInfoList({
    required this.appName,
    required this.appVersion,
    required this.packageName,
    required this.installerStore,
    super.key,
  });
  final String appName;
  final String appVersion;
  final String packageName;
  final String installerStore;

  @override
  State<AppInfoList> createState() => _AppInfoListState();
}

class _AppInfoListState extends State<AppInfoList>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _slideAnimations;

  Map<String, String> get appInfo => {
    'appName': widget.appName,
    'appVersion': widget.appVersion,
    'dartVersion': 'Stable, ${Platform.version.split(" ").first}',
    'flutterVersion': 'Stable, ${FlutterVersion.version}',
    'packageName': widget.packageName,
    'installerStore': widget.installerStore,
  };

  @override
  void initState() {
    super.initState();
    _initAnimations(appInfo.keys.toList());
  }

  void _initAnimations(final appInfoList) async {
    _controllers = List.generate(
      appInfoList.length,
      (final index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300 + (index * 75)),
      ),
    );

    _slideAnimations = _controllers
        .map(
          (final controller) => Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut)),
        )
        .toList();

    // Delay start a bit for UX
    Future.delayed(const Duration(milliseconds: 200), () {
      for (var controller in _controllers) {
        controller.forward();
      }
    });
  }

  void copyToClipboard() {
    HapticFeedback.vibrate();
    Clipboard.setData(
      ClipboardData(
        text:
            '''
معلومات تطبيق تضامن:
- اسم التطبيق: ${widget.appName}
- إصدار التطبيق: ${widget.appVersion}
- اسم الحزمة: ${widget.packageName}
- المتجر المثبت: ${widget.installerStore}
''',
      ),
    );
  }

  @override
  Widget build(final BuildContext context) => Column(
    children: [
      SlideTransition(
        position: _slideAnimations.first,
        child: FadeTransition(
          opacity: _controllers.first,
          child: const AppInfoTitle(),
        ),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: appInfo.length,
          itemBuilder: (final context, final index) {
            final key = appInfo.keys.elementAt(index);
            final value = appInfo[key] ?? 'غير معروف';
            return SlideTransition(
              position: _slideAnimations[index],
              child: FadeTransition(
                opacity: _controllers[index],
                child: Column(
                  children: [
                    ListTileIconComponent(
                      leading: _getIcons(key),
                      title: _getTitle(key),
                      subtitle: value,
                      groupType: index == 0
                          ? ListTileGroupType.top
                          : index < appInfo.length - 1
                          ? ListTileGroupType.middle
                          : ListTileGroupType.bottom,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      SlideTransition(
        position: _slideAnimations.last,
        child: FadeTransition(
          opacity: _controllers.last,
          child: SizedBox(
            width: double.infinity,
            child: ButtonCompnent(
              label: 'نسخ معلومات التطبيق',
              icon: Icons.copy_all_rounded,
              useMargin: true,
              onPressed: () => copyToClipboard(),
            ),
          ),
        ),
      ),
    ],
  );

  IconData _getIcons(final String key) {
    switch (key) {
      case 'appName':
        return Icons.android_rounded;
      case 'appVersion':
        return Icons.phone_android_rounded;
      case 'dartVersion':
        return Icons.code_rounded;
      case 'flutterVersion':
        return Icons.flutter_dash;
      case 'packageName':
        return Icons.app_registration_outlined;
      case 'installerStore':
        return Icons.store_outlined;
      default:
        return Icons.help_outline;
    }
  }

  String _getTitle(final String key) {
    switch (key) {
      case 'OS':
        return 'نظام التشغيل';
      case 'appName':
        return 'اسم التطبيق';
      case 'appVersion':
        return 'إصدار التطبيق';
      case 'dartVersion':
        return 'إصدار Dart';
      case 'flutterVersion':
        return 'إصدار Flutter';
      case 'packageName':
        return 'اسم الحزمة';
      case 'installerStore':
        return 'المتجر المثبت';
      default:
        return key;
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
