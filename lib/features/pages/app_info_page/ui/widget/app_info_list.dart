import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tadamon/core/config/const/app_enums.dart'
    show ListTileGroupType;
import 'package:tadamon/core/widgets/button_component/button_compnent.dart';
import 'package:tadamon/core/widgets/drawer_component/drawer_component.dart';
import 'package:tadamon/features/pages/app_info_page/ui/widget/app_info_title.dart';

class AppInfoList extends StatefulWidget {
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
    'buildNumber': widget.buildNumber,
    'buildSignature': widget.buildSignature,
    'packageName': widget.packageName,
    'installerStore': widget.installerStore,
  };

  @override
  void initState() {
    super.initState();
    _initAnimations(appInfo.keys.toList());
  }

  void _initAnimations(final dynamic appInfoList) async {
    _controllers = List.generate(
      appInfoList.length,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300 + (index * 75)),
      ),
    );

    _slideAnimations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    }).toList();

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
- رقم البناء: ${widget.buildNumber}
- توقيع البناء: ${widget.buildSignature}
- اسم الحزمة: ${widget.packageName}
- المتجر المثبت: ${widget.installerStore}
''',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            itemBuilder: (context, index) {
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
                label: "نسخ معلومات التطبيق",
                icon: Icons.copy_all_rounded,
                useMargin: true,
                onPressed: () => copyToClipboard(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  IconData _getIcons(String key) {
    switch (key) {
      case 'appName':
        return Icons.android_rounded;
      case 'appVersion':
        return Icons.info_outline;
      case 'buildNumber':
        return Icons.build_outlined;
      case 'buildSignature':
        return Icons.code_outlined;
      case 'packageName':
        return Icons.app_registration_outlined;
      case 'installerStore':
        return Icons.store_outlined;
      default:
        return Icons.help_outline;
    }
  }

  String _getTitle(String key) {
    switch (key) {
      case 'appName':
        return 'اسم التطبيق';
      case 'appVersion':
        return 'إصدار التطبيق';
      case 'buildNumber':
        return 'رقم البناء';
      case 'buildSignature':
        return 'توقيع البناء';
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
