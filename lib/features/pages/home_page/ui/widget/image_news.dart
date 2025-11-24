import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/config/const/sensei_const.dart';
import '../../logic/cubit/home_cubit.dart';

class ImageNews extends StatefulWidget {
  const ImageNews({super.key});

  @override
  State<ImageNews> createState() => _ImageNewsState();
}

class _ImageNewsState extends State<ImageNews> {
  static const Duration _slideTransitionDuration = Duration(milliseconds: 400);
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    final state = context.read<HomeCubit>().state;
    _pageController = PageController(
      initialPage: state is HomeLoaded ? state.currentPage : 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildImageSlide(final String imageUrl) => CachedNetworkImage(
    imageUrl: imageUrl,
    fit: BoxFit.cover,
    filterQuality: FilterQuality.medium,
    errorWidget: (final context, final url, final error) => Container(
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
          const Text('Failed to load image'),
        ],
      ),
    ),
  );

  @override
  Widget build(final BuildContext context) =>
      BlocConsumer<HomeCubit, HomeState>(
        listener: (final context, final state) {
          if (state is HomeLoaded) {
            // Animate to the new page when the state changes
            if (_pageController.page?.round() != state.currentPage) {
              _pageController.animateToPage(
                state.currentPage,
                duration: _slideTransitionDuration,
                curve: Curves.easeInOut,
              );
            }
          }
        },
        builder: (final context, final state) {
          if (state is HomeLoaded) {
            return GestureDetector(
              onTapDown: (_) => context.read<HomeCubit>().pauseAutoSlide(),
              onTapUp: (_) => context.read<HomeCubit>().resumeAutoSlide(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    SenseiConst.outBorderRadius,
                  ),
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(SenseiConst.padding.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          SenseiConst.inBorderRadius,
                        ),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: state.imageUrls.length,
                            itemBuilder: (final context, final index) =>
                                _buildImageSlide(state.imageUrls[index]),
                            onPageChanged: (final index) =>
                                context.read<HomeCubit>().pageChanged(index),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: SenseiConst.padding.h),
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: state.imageUrls.length,
                        effect: ExpandingDotsEffect(
                          dotWidth: SenseiConst.indicatorDotSize,
                          dotHeight: SenseiConst.indicatorDotSize,
                          dotColor: Theme.of(context).colorScheme.onSurface
                              .withAlpha((0.5 * 255).toInt()),
                          activeDotColor: Theme.of(
                            context,
                          ).colorScheme.primaryContainer,
                          expansionFactor: 2,
                        ),
                        onDotClicked: (final index) {
                          _pageController.animateToPage(
                            index,
                            duration: _slideTransitionDuration,
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          // Show a loading indicator or an empty box
          return const SizedBox.shrink();
        },
      );
}
