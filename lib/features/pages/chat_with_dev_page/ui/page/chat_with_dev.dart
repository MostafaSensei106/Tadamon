import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/services/url_services/url_services.dart';
import 'package:tadamon/core/widgets/app_toast/app_toast.dart';
import 'package:tadamon/core/widgets/icon_button_component/icon_button_filledtonal_component.dart';
import 'package:tadamon/core/widgets/text_filed_component/text_filed_component.dart';
import 'package:tadamon/features/pages/chat_with_dev_page/ui/widget/chat_bubble.dart';
import 'package:tadamon/features/pages/chat_with_dev_page/ui/widget/chat_dev_app_bar.dart';
import 'package:tadamon/generated/l10n.dart';

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


    void _initAnimations(final dynamic messagesList) async {
    _controllers = List.generate(
      messagesList.length,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300 + (index * 75)),
      ),
    );

    _slideAnimations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ));
    }).toList();

    // Delay start a bit for UX
    Future.delayed(const Duration(milliseconds: 200), () {
      for (var controller in _controllers) {
        controller.forward();
      }
    });
  }



  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatDevAppBar(title: S.of(context).mostafaMahmoud),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: SenseiConst.padding.w),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final dateTime = now.subtract(
                  Duration(
                    minutes: (messages.length - 1 - index),
                  ),
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
  }

  Future<void> sendMessage() async {
    try {
      HapticFeedback.vibrate();
      final String message = _controller.text;
      if (message.isNotEmpty) {
        await UrlRunServices.sendEmail(
          toEmail: 'mostafa438886@fci.bu.edu.eg',
          subject: 'مرحبا، MR: Mostafa Sensei',
          body: message,
        );
        _controller.clear();
      }
    } catch (e) {
      AppToast.showErrorToast(e.toString());
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
