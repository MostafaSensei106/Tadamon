import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/help_user_cubit.dart';
import '../widget/help_user_page_view.dart';

class HelpUserPage extends StatelessWidget {
  const HelpUserPage({super.key});
  @override
  Widget build(final BuildContext context) => BlocProvider(
      create: (final context) => HelpUserCubit(),
      child: const HelpUserPageView(),
    );
}
