import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/const/sensei_const.dart';
import '../../logic/cubit/home_cubit.dart';
import '../widget/home_app_tools.dart';
import '../widget/home_tip.dart';
import '../widget/image_news.dart';
import '../widget/items_counter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (_) => HomeCubit()..loadContent(),
    child: const Padding(
      padding: EdgeInsets.all(SenseiConst.padding),
      child: Column(
        children: [HomeTip(), ImageNews(), HomeAppTools(), ItemsCounter()],
      ),
    ),
  );
}
