import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/const/sensei_const.dart';
import '../../../../../core/services/url_services/url_services.dart';
import '../../../../../core/widgets/app_toast/app_toast.dart';
import '../../../../../core/widgets/button_components/icon_button_components/icon_button_filledtonal_component.dart'
    show IconButtonFilledTonalComponent;
import '../../../../../core/widgets/text_filed_component/text_filed_component.dart';
import '../../../../../l10n/app_localizations.dart';
import '../widget/chat_bubble.dart';
import '../widget/chat_dev_app_bar.dart';

class ChatWithDev extends StatefulWidget {
  const ChatWithDev({super.key});

  @override
  State<ChatWithDev> createState() => _ChatWithDevState();
}

class _ChatWithDevState extends State<ChatWithDev>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _slideAnimations;

  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {
      'text':
          'شكرًا لاستخدامك تطبيق "تضامن". وعيك واختيارك يُحدثان فرقًا حقيقيًا في دعم القضية الفلسطينية.',
      'isSentByMe': false,
    },
    {
      'text':
          'إذا كنت ترغب، يمكنك الضغط على الصورة أعلاه لدعم هذا المشروع اختياريًا.',
      'isSentByMe': false,
      'isSupportDevButton': true,
    },
    {
      'text': 'ولا تنسَ مشاركة التطبيق مع من حولك، فالتأثير يبدأ بخطوة.',
      'isSentByMe': false,
    },
    {
      'text':
          'يمكنك مشاركة التطبيق والاطلاع على ملفي الشخصي من خلال الروابط أدناه',
      'isSentByMe': false,
      'isShareButton': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _initAnimations(messages);
  }

  void _initAnimations(final messagesList) async {
    _controllers = List.generate(
      messagesList.length,
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

  DateTime now = DateTime.now();

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: ChatDevAppBar(title: AppLocalizations.of(context)!.mostafaMahmoud),
    body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: SenseiConst.padding.w),
            itemCount: messages.length,
            itemBuilder: (final context, final index) {
              final dateTime = now.subtract(
                Duration(minutes: (messages.length - 1 - index)),
              );
              return SlideTransition(
                position: _slideAnimations[index],
                child: FadeTransition(
                  opacity: _controllers[index],
                  child: ChatBubble(
                    text: messages[index]['text'],
                    isSentByMe: messages[index]['isSentByMe'],
                    isSupportDevButton:
                        messages[index]['isSupportDevButton'] ?? false,
                    isShareButton: messages[index]['isShareButton'] ?? false,
                    time: dateTime,
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
            child: Padding(
              padding: const EdgeInsets.only(
                left: SenseiConst.padding,
                right: SenseiConst.padding,
                bottom: 5.0,
                top: 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                spacing: SenseiConst.padding,
                children: [
                  Expanded(
                    child: TextFieldComponent(
                      controller: _controller,
                      icon: Icons.message_outlined,
                      useOutBorderRadius: true,
                      hint: '...اكتب رسالة',
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                    height: 50.h,
                    child: IconButtonFilledTonalComponent(
                      icon: Icons.send_rounded,
                      onPressed: () {
                        sendMessage();
                      },
                      color: Theme.of(context).colorScheme.secondaryFixed,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Future<void> sendMessage() async {
    try {
      HapticFeedback.vibrate();
      final message = _controller.text;
      if (message.isNotEmpty) {
        await sendEmail(
          toEmail: 'mostafa438886@fci.bu.edu.eg',
          subject: 'مرحبا، MR: Mostafa Sensei',
          body: message,
        );
        _controller.clear();
      }
    } catch (e) {
      showErrorToast(e.toString());
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _controller.dispose();
    super.dispose();
  }
}
