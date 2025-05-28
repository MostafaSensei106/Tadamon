import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/services/url_services/url_services.dart';

class ChatDevAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const ChatDevAppBar({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  /// Navigate back in the app by calling [Navigator.pop] on the given [context], and
  /// trigger a haptic feedback with [HapticFeedback.vibrate].
  void leave(context) {
    HapticFeedback.vibrate();
    Navigator.pop(context);
  }

  @override

  /// Returns an [AppBar] widget with a centered title and a leading widget that is a left
  /// arrow icon. When the icon is tapped, it triggers the [leave] function to navigate back in
  /// the app. The [AppBar] has no elevation and a white background.
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 20.sp),
      ),
      leadingWidth: 102.w,
      titleSpacing: 0,
      centerTitle: true,
      elevation: 0,
      forceMaterialTransparency: true,
      leading: _buildSidePageAppBarIcon(
          context, Icons.keyboard_double_arrow_right_rounded),
      actions: [
        _buildActionBarIcon(
          context,
          Icons.call_outlined,
          () {
            HapticFeedback.vibrate();
            UrlRunServices.makePhoneCall(SenseiConst.devPhoneNumber);
          },
        ),
        _buildActionBarIcon(
          context,
          Icons.telegram_outlined,
          () {
            HapticFeedback.vibrate();
            UrlRunServices.launchURL(SenseiConst.devTelegramLink);
          },
        ),
      ],
    );
  }

  /// Returns a [Padding] widget containing a [Material] widget with an [InkWell] child.
  ///
  /// The [InkWell] widget has a rounded border and is wrapped in a transparent [Material] widget.
  /// When tapped, it triggers the [leave] function to navigate back in the app.
  ///
  /// The [InkWell] contains a [Container] with a rounded border and a background color of
  /// [Theme.of(context).colorScheme.surfaceContainer]. Inside the [Container] is an [Icon] widget
  /// with the provided [icon] parameter, sized according to [SenseiConst.iconSize] and colored
  /// using [Theme.of(context).colorScheme.onSurface].

  Widget _buildSidePageAppBarIcon(BuildContext context, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(SenseiConst.padding),
      child: Row(
        children: [
          IconButton.filled(
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(SenseiConst.outBorderRadius),
              ),
              padding: const EdgeInsets.all(4),
            ),
            onPressed: () => leave(context),
            icon: Icon(
              icon,
              size: SenseiConst.iconSize,
            ),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          Stack(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(
                  SenseiConst.mostafaSenseiogoImage,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.surface, width: 1),
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionBarIcon(
      BuildContext context, IconData icon, final VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon),
      color: Theme.of(context).colorScheme.onSurface,
      onPressed: onPressed,
    );
  }
}
