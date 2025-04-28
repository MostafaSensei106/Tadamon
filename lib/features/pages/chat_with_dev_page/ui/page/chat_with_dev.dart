import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/services/url_services/url_services.dart';
import 'package:tadamon/core/widgets/app_toast/app_toast.dart';
import 'package:tadamon/core/widgets/text_filed_component/text_filed_component.dart';
import 'package:tadamon/features/pages/chat_with_dev_page/ui/widget/chat_bubble.dart';
import 'package:tadamon/features/pages/chat_with_dev_page/ui/widget/chat_dev_app_bar.dart';
import 'package:tadamon/generated/l10n.dart';

class ChatWithDev extends StatelessWidget {
  ChatWithDev({super.key});
  final TextEditingController _controller = TextEditingController();
  void dispose() {
    _controller.dispose();
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
  Widget build(BuildContext context) {
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
        'isShareButton': true
      }
    ];

    final now = DateTime.now();
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
                return ChatBubble(
                  text: messages[index]['text'],
                  isSentByMe: messages[index]['isSentByMe'],
                  isSupportDevButton:
                      messages[index]['isSupportDevButton'] ?? false,
                  isShareButton: messages[index]['isShareButton'] ?? false,
                  time: dateTime,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: SenseiConst.padding,
              right: SenseiConst.padding,
              bottom: 5.0,
              top: 5.0,
            ),
            child: TextFieldComponent(
              controller: _controller,
              icon: Icons.message_outlined,
              useOutBorderRadius: true,
              hint: '...اكتب رسالة',
              suffixIcon: IconButton(
                onPressed: () => sendMessage(),
                icon: const Icon(Icons.send_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
