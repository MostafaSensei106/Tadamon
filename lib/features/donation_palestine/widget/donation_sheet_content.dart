import 'package:flutter/cupertino.dart' show SingleChildScrollView;
import 'package:flutter/material.dart' show Icons, ClipRRect;
import 'package:flutter/widgets.dart'
    show StatelessWidget, BuildContext, Widget, Column;
import 'package:pdf/widgets.dart' show Padding, Wrap;
import '../../../core/config/const/app_enums.dart' show ListTileGroupType;
import '../../../core/config/const/sensei_const.dart' show SenseiConst;
import '../../../core/services/url_services/url_services.dart' show launchURL;

import '../../../core/widgets/bottom_sheet/ui/model_bottom_sheet.dart'
    show showBottomSheet;
import '../../../core/widgets/drawer_component/drawer_component.dart'
    show ListTileIconComponent;
import '../../../generated/l10n.dart' show S;

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
  static void showDonationBottomSheet(final BuildContext context) {
    showBottomSheet(
      context,
      S.of(context).donate,
      child: const DonationSheetContent(),
    );
  }

  @override
  /// Builds a [Column] widget that displays a list of [ListTileIconComponent]s each
  /// with a different organization and its corresponding URL to donate.
  ///
  /// The first [ListTileIconComponent] is for the UNRWA organization, the second is
  /// for the Palestinian Red Crescent organization, the third is for the
  /// Baitzakat organization, and the fourth is for the Egyptian Food Bank
  /// organization.
  ///
  /// Each [ListTileIconComponent] has a different icon, title, and subtitle. The
  /// subtitle is a translation of "Donate through [organization name]".
  ///
  /// The [ListTileIconComponent]s are arranged vertically in a [Column] widget.
  ///
  /// The [ListTileIconComponent]s are wrapped in a [SingleChildScrollView] to make
  /// the bottom sheet scrollable.
  ///
  /// The [ListTileIconComponent]s are also padded with a [Padding] widget to add a
  /// bottom padding of 16 logical pixels.
  Widget build(final BuildContext context) => Column(
    children: [
      ListTileIconComponent(
        leading: Icons.volunteer_activism_outlined,
        title: 'منظمة الانوروا',
        subtitle: 'نبرع هم طريق منظمة الانوروا',

        useinBorderRadius: true,
        onTap: () => {launchURL(SenseiConst.donateByUnrwaLink)},
        groupType: ListTileGroupType.top,
      ),
      ListTileIconComponent(
        leading: Icons.mode_night_outlined,
        title: 'الهلال الاحمر الفلسطيني',
        subtitle: 'تبرع عن طريق الهلال الاحمر الفلسطيني',
        onTap: () => {launchURL(SenseiConst.donateByPalestinercsLink)},
        groupType: ListTileGroupType.middle,
      ),
      ListTileIconComponent(
        leading: Icons.maps_home_work_outlined,
        title: 'بيت الزكاة والصدقات المصري',
        subtitle: 'تبرع عن طريق ابيت الزكاةو الصدقات المصري',
        onTap: () => launchURL(SenseiConst.donateByBaitzakatLink),
        groupType: ListTileGroupType.middle,
      ),
      ListTileIconComponent(
        leading: Icons.food_bank_outlined,
        title: 'بنك الطعام المصري',
        subtitle: 'تبرع عن طريقة بنك الطعام المصري',
        onTap: () => {launchURL(SenseiConst.donateByEGYFoodBankLink)},
        useinBorderRadius: true,
        groupType: ListTileGroupType.bottom,
      ),
    ],
  );
}
