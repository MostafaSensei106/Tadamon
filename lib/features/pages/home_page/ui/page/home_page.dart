import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/items_counter.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/home_app_tools.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/home_tip.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/image_news.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _initAnimations(_widgets);
  }

  final List<Widget> _widgets = [
    const HomeTip(),
    const ImageNews(),
    const HomeAppTools(),
    const ItemsCounter(),
  ];

  void _initAnimations(final dynamic widgetsList) async {
    _controllers = List.generate(
      widgetsList.length,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300 + (index * 75)),
      ),
    );

    _slideAnimations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ));
    }).toList();

    // Delay start a bit for UX
    Future.delayed(const Duration(milliseconds: 200), () {
      for (var controller in _controllers) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _widgets.length,
        padding: const EdgeInsets.all(SenseiConst.padding),
        itemBuilder: (context, index) {
          return SlideTransition(
            position: _slideAnimations[index],
            child: FadeTransition(
              opacity: _controllers[index],
              child: _widgets[index],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
