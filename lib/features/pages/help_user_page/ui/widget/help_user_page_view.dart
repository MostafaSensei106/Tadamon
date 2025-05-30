import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/expansion_tile_component/expansion_tile_component.dart';
import 'package:tadamon/features/pages/help_user_page/logic/cubit/help_user_cubit.dart';
import 'package:tadamon/features/pages/help_user_page/logic/cubit/help_user_state.dart';
import 'package:tadamon/core/widgets/app_bar/side_page_app_bar.dart';
import 'package:tadamon/generated/l10n.dart';

class HelpUserPageView extends StatelessWidget {
  const HelpUserPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          SidePageAppBar(title: S.of(context).howToUse, useBackButton: true),
      body: BlocBuilder<HelpUserCubit, HelpUserState>(
        builder: (context, state) {
          if (state is HlepUserLoadingQnaState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HelpUserErrorState) {
            return Center(
              child: Column(
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
              ),
            );
          }

          if (state is HlepUserLoadingQnaStateSuccess) {
            final List<AnimationController> controllers = List.generate(
              state.qnaList.length,
              (index) => AnimationController(
                vsync: context as TickerProviderStateMixin,
                duration: Duration(milliseconds: 300 + (index * 75)),
              ),
            );

            final List<Animation<Offset>> slideAnimations = controllers.map(
              (controller) {
                return Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: controller,
                  curve: Curves.easeOut,
                ));
              },
            ).toList();

            // Delay start a bit for UX
            Future.delayed(const Duration(milliseconds: 200), () {
              for (var controller in controllers) {
                controller.forward();
              }
            });
            return ListView.builder(
              itemCount: state.qnaList.length,
              padding: EdgeInsets.all(SenseiConst.padding.w),
              itemBuilder: (context, index) {
                final qna = state.qnaList[index];
                return SlideTransition(
                  position: slideAnimations[index],
                  child: FadeTransition(
                    opacity: controllers[index],
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
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                            ),
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
  }
}
