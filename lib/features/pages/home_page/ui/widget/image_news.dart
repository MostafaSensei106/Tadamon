import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/config/const/sensei_const.dart';
import '../../logic/cubit/home_cubit.dart';

class ImageNews extends StatelessWidget {
  const ImageNews({super.key});

  static const Duration _slideTransitionDuration = Duration(milliseconds: 400);

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
      BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            final pageController = PageController(initialPage: state.currentPage);

            // Listen to state changes to animate the page controller
            // This is a workaround to animate the page view from the cubit
            pageController.addListener(() {
              if (pageController.page?.round() != state.currentPage) {
                pageController.animateToPage(
                  state.currentPage,
                  duration: _slideTransitionDuration,
                  curve: Curves.easeInOut,
                );
              }
            });

            return GestureDetector(
              onTapDown: (_) => context.read<HomeCubit>().pauseAutoSlide(),
              onTapUp: (_) => context.read<HomeCubit>().resumeAutoSlide(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(SenseiConst.padding.w),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(SenseiConst.inBorderRadius),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: PageView.builder(
                            controller: pageController,
                            physics: const ScrollPhysics(),
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
                        controller: pageController,
                        count: state.imageUrls.length,
                        effect: ExpandingDotsEffect(
                          dotWidth: SenseiConst.indicatorDotSize,
                          dotHeight: SenseiConst.indicatorDotSize,
                          dotColor: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha((0.5 * 255).toInt()),
                          activeDotColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          expansionFactor: 2,
                        ),
                        onDotClicked: (final index) {
                          pageController.animateToPage(
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
          return const SizedBox.shrink(); // or a loading indicator
        },
      );
}
