import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/const/sensei_const.dart';
import 'about_section.dart';
import 'actions_section.dart';
import 'data_management_section.dart';
import 'drawer_header.dart';
import 'links_section.dart';
import 'theme_section.dart';

class SenseiDrawer extends StatelessWidget {
  const SenseiDrawer({super.key});

  @override
  Widget build(final BuildContext context) => SizedBox(
    width: 0.90.sw,
    child: Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(SenseiConst.outBorderRadius),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.only(bottom: SenseiConst.padding),
        children: const [
          DrawerHeaderWidget(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SenseiConst.padding),
            child: Column(
              children: [
                ThemeSection(),
                DataManagementSection(),
                ActionsSection(),
                LinksSection(),
                AboutSection(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
