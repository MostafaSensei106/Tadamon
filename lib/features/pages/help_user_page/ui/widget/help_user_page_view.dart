import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/const/sensei_const.dart';
import '../../../../../core/widgets/app_bar/side_page_app_bar.dart';
import '../../../../../core/widgets/expansion_tile_component/expansion_tile_component.dart';
import '../../../../../generated/l10n.dart';
import '../../logic/cubit/help_user_cubit.dart';
import '../../logic/cubit/help_user_state.dart';

class HelpUserPageView extends StatefulWidget {
  const HelpUserPageView({super.key});

  @override
  State<HelpUserPageView> createState() => _HelpUserPageViewState();
}

class _HelpUserPageViewState extends State<HelpUserPageView>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _slideAnimations;

  void _initAnimations(final qnaList) async {
    _controllers = List.generate(
      qnaList.length,
      (final index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300 + (index * 75)),
      ),
    );

    _slideAnimations = _controllers
        .map(
          (final controller) => Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut)),
        )
        .toList();

    // Delay start a bit for UX
    Future.delayed(const Duration(milliseconds: 200), () {
      for (var controller in _controllers) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: SidePageAppBar(title: S.of(context).howToUse, useBackButton: true),
    body: BlocBuilder<HelpUserCubit, HelpUserState>(
      builder: (final context, final state) {
        if (state is HlepUserLoadingQnaState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HelpUserErrorState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(state.error),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.read<HelpUserCubit>().loadQna(),
                child: const Text('إعادة المحاولة'),
              ),
            ],
          );
        }

        if (state is HlepUserLoadingQnaStateSuccess) {
          _initAnimations(state.qnaList);
          return ListView.builder(
            itemCount: state.qnaList.length,
            padding: EdgeInsets.all(SenseiConst.padding.w),
            itemBuilder: (final context, final index) {
              final qna = state.qnaList[index];
              return SlideTransition(
                position: _slideAnimations[index],
                child: FadeTransition(
                  opacity: _controllers[index],
                  child: ExpansionTileComponent(
                    useMargin: index == 0 ? false : true,
                    leadingIcon: Icons.help_outline,
                    title: qna.question,
                    subtitle: qna.simAnswer,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          qna.fullAnswer,
                          style: const TextStyle(fontSize: 16, height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    ),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
