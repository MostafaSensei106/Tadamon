import 'package:flutter/material.dart';
import '../../../home_page/ui/page/home_page.dart';
import '../../../log_page/ui/page/log_page.dart';
import '../../../search_page/ui/page/search_page.dart';

class MainPageContainer extends StatelessWidget {
  const MainPageContainer({
    required this.pageController,
    required this.onPageChanged,
    super.key,
  });
  final PageController pageController;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(final BuildContext context) => PageView(
    controller: pageController,
    onPageChanged: (final index) {
      if (index == 1 || index == 0 || index == 2) {
        FocusScope.of(context).unfocus();
      }
      onPageChanged(index);
    },
    children: const [HomePage(), SearchPage(), LogsPage()],
  );
}
