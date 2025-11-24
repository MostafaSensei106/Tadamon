import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/config/const/sensei_const.dart';
import '../../../../../core/services/share_Services/share_services.dart';
import '../../../../../core/services/url_services/url_services.dart';
import '../../../../../core/widgets/button_components/icon_button_components/icon_button_filledtonal_component.dart';
import 'donation_for_dev_slider.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    required this.text,
    required this.isSentByMe,
    required this.time,
    super.key,
    this.isSupportDevButton = false,
    this.isShareButton = false,
  });
  final String text;
  final bool isSentByMe;
  final bool isSupportDevButton;
  final bool isShareButton;
  final DateTime time;

  @override
  Widget build(final BuildContext context) {
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
                    children: [
                      IconButtonFilledTonalComponent(
                        icon: Icons.ios_share_rounded,
                        useInBorderRadius: true,
                        // color: Theme.of(context).colorScheme.secondaryFixed,
                        onPressed: () {
                          HapticFeedback.vibrate();
                          ShareServices.shareUrl(SenseiConst.tadamonGitHubLink);
                        },
                      ),
                      IconButtonFilledTonalComponent(
                        icon: Icons.link_rounded,
                        useInBorderRadius: true,
                        // color: Theme.of(context).colorScheme.secondaryFixed,
                        onPressed: () {
                          HapticFeedback.vibrate();
                          launchURL(SenseiConst.devPortfolioLink);
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
  const Message({required this.text, required this.isSentByMe, super.key});
  final String text;
  final bool isSentByMe;

  @override
  Widget build(final BuildContext context) => Text(
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

class DataTime extends StatelessWidget {
  const DataTime({
    required this.formattedTime,
    required this.isSentByMe,
    super.key,
  });

  final String formattedTime;
  final bool isSentByMe;

  @override
  Widget build(final BuildContext context) => Align(
    alignment: Alignment.bottomLeft,
    child: Text(
      formattedTime,
      style: TextStyle(
        fontSize: 12,
        color: isSentByMe
            ? Theme.of(context).colorScheme.onSecondaryContainer.withAlpha(0x50)
            : Theme.of(context).colorScheme.onSurface.withAlpha(0x50),
      ),
    ),
  );
}
