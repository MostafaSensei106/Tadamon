import 'package:flutter/material.dart';

import '../../../../../core/config/const/sensei_const.dart';
import '../widget/home_app_tools.dart';
import '../widget/home_tip.dart';
import '../widget/image_news.dart';
import '../widget/items_counter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context) => const Padding(
      padding: EdgeInsets.all(SenseiConst.padding),
      child: Column(
        children: [HomeTip(), ImageNews(), HomeAppTools(), ItemsCounter()],
      ),
    );
}
