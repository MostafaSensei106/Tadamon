import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/features/pages/help_user_page/logic/cubit/help_user_cubit.dart';
import 'package:tadamon/features/pages/help_user_page/ui/widget/help_user_page_view.dart';

class HelpUserPage extends StatelessWidget {
  const HelpUserPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HelpUserCubit(),
      child: const HelpUserPageView(),
    );
  }
}
