import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tadamon/core/routing/routes.dart';
import 'package:tadamon/features/pages/onboarding_page/ui/widget/animated_triangles.dart';
import 'package:tadamon/features/pages/onboarding_page/ui/widget/dot_indicator_nav.dart';
import 'package:tadamon/features/pages/onboarding_page/ui/widget/onboarding_page_one.dart';
import 'package:tadamon/features/pages/onboarding_page/ui/widget/onboarding_page_two.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _checkAgreement();
  }

  Future<void> _checkAgreement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool agreed = prefs.getBool('agreed_to_terms') ?? false;
    if (agreed) {
      _navigateToHome();
    } else {
      setState(() => _loading = false);
    }
  }

  void _navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.mainPage,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedTriangles(),
          PageView(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            children: [
              const OnboardingPageOne(),
              const OnboardingPageTwo(
                firstIcon: Icons.qr_code_rounded,
                secondIcon: Icons.image_search_rounded,
                firstTitle: 'فحص الباركود',
                secondTitle: 'تحليل الصور',
                subtitle:
                    "اكشف عن المنتجات باستخدام الكاميرا أو حلل الصور بتقنية تعلّم الآلة.",
              ),
              const OnboardingPageTwo(
                firstIcon: Icons.search_rounded,
                secondIcon: Icons.new_releases_outlined,
                firstTitle: 'ابحث عن المنتج',
                secondTitle: 'اعثر على البدائل',
                subtitle:
                    'ابحث عن المنتجات واحصل علي البدائل لمنتجات المقاطعة بكل سهولة.',
              ),
              const OnboardingPageTwo(
                height: 75.5,
                appOnlineRun: true,
                firstIcon: Icons.cloud_done_outlined,
                secondIcon: Icons.cloud_off_rounded,
                firstTitle: 'مع اتصال بالإنترنت',
                secondTitle: 'دون اتصال بالإنترنت',
                subtitle:
                    ' اضغط على الزر الموجود في الاسفل لتفعيل التطبيق يعمل بكفاءة سواء كنت متصلاً بالإنترنت أو لا.',
              ),
            ],
          ),
          DotIndicatorNav(pageController: _pageController),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
