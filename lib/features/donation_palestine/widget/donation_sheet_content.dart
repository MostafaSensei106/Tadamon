import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/services/url_services/url_services.dart';
import 'package:tadamon/core/widgets/bottom_sheet/ui/model_bottom_sheet.dart';
import 'package:tadamon/core/widgets/drawer_component/drawer_component.dart';
import 'package:tadamon/generated/l10n.dart';

class DonationSheetContent extends StatelessWidget {
  const DonationSheetContent({super.key});

  /// Shows a bottom sheet with the title translated to "Donate" and a
  /// [DonationSheetContent] as its child in the given [context].
  ///
  /// The bottom sheet is scrollable, has a top border radius of 14 logical
  /// pixels, uses the root navigator, and is dismissible.
  ///
  /// The [DonationSheetContent] is displayed within a [ClipRRect] with a
  /// circular corner radius of 14 logical pixels.
  ///
  /// The [DonationSheetContent] is wrapped in a [Column] with a [Padding]
  /// widget to add horizontal padding and a [Wrap] widget to stack the title
  /// and the child vertically.
  ///
  /// The [DonationSheetContent] is also wrapped in a [SingleChildScrollView]
  /// to make the bottom sheet scrollable.
  ///
  /// The [DonationSheetContent] is displayed at the bottom of the screen with
  /// a padding of 16 logical pixels.
  ///
  /// The [DonationSheetContent] is also padded with a [Padding] widget to add
  /// a bottom padding of 16 logical pixels.
  static void showDonationBottomSheet(BuildContext context) {
    ModelBottomSheet.show(
      context,
      S.of(context).donate,
      child: const DonationSheetContent(),
    );
  }

  @override
  /// Builds a [Column] widget that displays a list of [ListTileComponent]s each
  /// with a different organization and its corresponding URL to donate.
  ///
  /// The first [ListTileComponent] is for the UNRWA organization, the second is
  /// for the Palestinian Red Crescent organization, the third is for the
  /// Baitzakat organization, and the fourth is for the Egyptian Food Bank
  /// organization.
  ///
  /// Each [ListTileComponent] has a different icon, title, and subtitle. The
  /// subtitle is a translation of "Donate through [organization name]".
  ///
  /// The [ListTileComponent]s are arranged vertically in a [Column] widget.
  ///
  /// The [ListTileComponent]s are wrapped in a [SingleChildScrollView] to make
  /// the bottom sheet scrollable.
  ///
  /// The [ListTileComponent]s are also padded with a [Padding] widget to add a
  /// bottom padding of 16 logical pixels.
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTileComponent(
          leadingIcon: Icons.volunteer_activism_outlined,
          title: 'منظمة الانوروا',
          subtitle: 'نبرع هم طريق منظمة الانوروا',
          useDivider: true,
          useGroupTop: true,
          useinBorderRadius: true,
          onTapped: () => {
            HapticFeedback.vibrate(),
            UrlRunServices.launchURL(SenseiConst.donateByUnrwaLink),
          },
        ),
        ListTileComponent(
          leadingIcon: Icons.mode_night_outlined,
          title: 'الهلال الاحمر الفلسطيني',
          subtitle: 'تبرع عن طريق الهلال الاحمر الفلسطيني',
          useDivider: true,
          useGroupMiddle: true,
          onTapped: () => {
            HapticFeedback.vibrate(),
            UrlRunServices.launchURL(SenseiConst.donateByPalestinercsLink),
          },
        ),
        ListTileComponent(
          leadingIcon: Icons.maps_home_work_outlined,
          title: 'بيت الزكاة والصدقات المصري',
          subtitle: 'تبرع عن طريق ابيت الزكاةو الصدقات المصري',
          useDivider: true,
          useGroupMiddle: true,
          useinBorderRadius: true,
          onTapped: () =>
              UrlRunServices.launchURL(SenseiConst.donateByBaitzakatLink),
        ),
        ListTileComponent(
          leadingIcon: Icons.food_bank_outlined,
          title: 'بنك الطعام المصري',
          subtitle: 'تبرع عن طريقة بنك الطعام المصري',
          useinBorderRadius: true,
          useGroupBottom: true,
          onTapped: () => {
            HapticFeedback.vibrate(),
            UrlRunServices.launchURL(SenseiConst.donateByEGYFoodBankLink),
          },
        ),
      ],
    );
  }
}
