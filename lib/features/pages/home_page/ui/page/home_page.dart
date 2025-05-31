import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/items_counter.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/home_app_tools.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/home_tip.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/image_news.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(SenseiConst.padding),
      child: Column(
        children: [
          HomeTip(),
          ImageNews(),
          HomeAppTools(),
          ItemsCounter(),
        ],
      ),
    );
  }
}
