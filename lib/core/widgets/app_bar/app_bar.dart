import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/app_bar/action_drawer_icons.dart';
import 'package:tadamon/core/widgets/app_bar/app_bar_title.dart';

class SenseiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SenseiAppBar(this.title, {super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(SenseiConst.waterMelonCoverImage),
          fit: BoxFit.cover,
        ),
      ),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const ActionDrawerIcon(),
        title: AppBarTitle(title: title),
      ),
    );
  }
}
