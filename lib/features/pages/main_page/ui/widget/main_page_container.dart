import 'package:flutter/material.dart';
import 'package:tadamon/features/pages/home_page/ui/page/home_page.dart';
import 'package:tadamon/features/pages/log_page/ui/page/log_page.dart';
import 'package:tadamon/features/pages/search_page/ui/page/search_page.dart';

class MainPageContainer extends StatelessWidget {
  final PageController pageController;
  final ValueChanged<int> onPageChanged;

  const MainPageContainer({
    super.key,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        if (index == 1 || index == 0 || index == 2) {
          FocusScope.of(context).unfocus();
        }
        onPageChanged(index);
      },
      children: [
        const HomePage(),
        const SearchPage(),
        const LogsPage(),
      ],
    );
  }
}
