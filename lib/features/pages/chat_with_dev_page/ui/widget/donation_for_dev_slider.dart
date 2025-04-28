import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/services/url_services/url_services.dart';

class DonationForDevSlider extends StatefulWidget {
  const DonationForDevSlider({super.key});

  @override
  State<DonationForDevSlider> createState() => _DonationForDevSliderState();
}

class _DonationForDevSliderState extends State<DonationForDevSlider> {

  static const Duration _autoSlideDuration = Duration(seconds: 3);
  static const Duration _slideTransitionDuration = Duration(milliseconds: 400);
  late final PageController _pageController;
  Timer? _autoSlideTimer;

  final List<String> _imagesPaths = [
    SenseiConst.buyMeACoffeeImage,
    //SenseiConst.vodafoneCashImage,
  ];

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _initializeSlider();
  }

  void _initializeSlider() {
    _pageController = PageController(initialPage: 0);
    _startAutoSlide();

    _pageController.addListener(() {
      final newPage = _pageController.page?.round() ?? 0;
      if (_currentPage != newPage) {
        setState(() => _currentPage = newPage);
      }
    });
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(_autoSlideDuration, (_) {
      if (!mounted) return;

      if (_currentPage < _imagesPaths.length - 1) {
        _pageController.nextPage(
          duration: _slideTransitionDuration,
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: _slideTransitionDuration,
          curve: Curves.easeInOut,
        );
      }
    }
    );
  }

  void _pauseAutoSlide() {
    _autoSlideTimer?.cancel();
  }

  void _resumeAutoSlide() {
    _startAutoSlide();
  }

  Widget _buildImageSlide(String imageAsset) {
    return Image.asset(
      imageAsset,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              color: Theme.of(context).colorScheme.error,
              size: SenseiConst.iconSize,
            ),
            const Text('فشل تحميل الصورة'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pauseAutoSlide(),
      onTapUp: (_) => _resumeAutoSlide(),
      onTap: () {HapticFeedback.vibrate(); UrlRunServices.launchURL(SenseiConst.buyMeACoffeeLink);},
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: SenseiConst.padding.h-4),
        child: AspectRatio(
          aspectRatio: 35 / 10, 
          child: ClipRRect(
            borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
            child: PageView.builder(
              controller: _pageController,
              pageSnapping: true,
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              itemCount: _imagesPaths.length,
              itemBuilder: (context, index) =>
                  _buildImageSlide(_imagesPaths[index]),
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _pageController.dispose();
    _autoSlideTimer?.cancel();
    super.dispose();
  }
}
