import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/services/share_Services/share_services.dart';
import 'package:tadamon/core/services/url_services/url_services.dart';
import 'package:tadamon/core/widgets/icon_button_component/icon_button_filledtonal_component.dart';
import 'package:tadamon/features/pages/chat_with_dev_page/ui/widget/donation_for_dev_slider.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSentByMe;
  final bool isSupportDevButton;
  final bool isShareButton;
  final DateTime time;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isSentByMe,
    this.isSupportDevButton = false,
    this.isShareButton = false,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat('hh:mm a', 'en').format(time);
    return Align(
      alignment: isSentByMe ? Alignment.bottomRight : Alignment.bottomLeft,
      child: Row(
        mainAxisAlignment: isSentByMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isSentByMe)
            const Padding(
              padding: EdgeInsets.only(right: SenseiConst.padding),
              child: CircleAvatar(
                backgroundImage: AssetImage(SenseiConst.mostafaSenseiogoImage),
                radius: SenseiConst.outBorderRadius,
              ),
            ),
          Container(
            constraints: BoxConstraints(maxWidth: 0.75.sw),
            padding: const EdgeInsets.symmetric(
              horizontal: SenseiConst.padding,
              vertical: 4.0,
            ),
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: isSentByMe
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
            ),
            child: Column(
              crossAxisAlignment: isSentByMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (isSupportDevButton) const DonationForDevSlider(),
                Message(text: text, isSentByMe: isSentByMe),
                if (isShareButton)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButtonFilledTonalComponent(
                        icon: Icons.ios_share_rounded,
                        useInBorderRadius: true,
                        color: Theme.of(context).colorScheme.secondaryFixed,
                        onPressed: () {
                          HapticFeedback.vibrate();
                          ShareServices.share(SenseiConst.tadamonGitHubLink);
                        },
                      ),
                      IconButtonFilledTonalComponent(
                        icon: Icons.link_rounded,
                        useInBorderRadius: true,
                        color: Theme.of(context).colorScheme.secondaryFixed,
                        onPressed: () {
                          HapticFeedback.vibrate();
                          UrlRunServices.launchURL(
                            SenseiConst.devPortfolioLink,
                          );
                        },
                      ),
                    ],
                  ),
                const SizedBox(height: 4),
                DataTime(formattedTime: formattedTime, isSentByMe: isSentByMe),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message extends StatelessWidget {
  const Message({super.key, required this.text, required this.isSentByMe});
  final String text;
  final bool isSentByMe;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        textBaseline: TextBaseline.alphabetic,
        color: isSentByMe
            ? Theme.of(context).colorScheme.onSecondaryContainer
            : Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

class DataTime extends StatelessWidget {
  const DataTime({
    super.key,
    required this.formattedTime,
    required this.isSentByMe,
  });

  final String formattedTime;
  final bool isSentByMe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        formattedTime,
        style: TextStyle(
          fontSize: 12,
          color: isSentByMe
              ? Theme.of(
                  context,
                ).colorScheme.onSecondaryContainer.withAlpha(0x50)
              : Theme.of(context).colorScheme.onSurface.withAlpha(0x50),
        ),
      ),
    );
  }
}
