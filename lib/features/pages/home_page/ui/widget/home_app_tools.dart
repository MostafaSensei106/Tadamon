import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/routing/routes.dart';
import 'package:tadamon/features/donation_palestine/widget/donation_sheet_content.dart';
import 'package:tadamon/features/edit_text/widgets/edit_text_sheet_content.dart';
import 'package:tadamon/core/widgets/home_tool_component/home_tool_component.dart';
import 'package:tadamon/features/products_scanner/logic/cubit/product_scan_cubit/product_scan_cubit.dart';
import 'package:tadamon/generated/l10n.dart';

class HomeAppTools extends StatelessWidget {
  const HomeAppTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SenseiConst.margin.h),
      padding: EdgeInsets.symmetric(horizontal: 2.w,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: SenseiConst.padding.h,
        ),
        child: Row(
          children: [
            BlocProvider(
              create: (_) => ProductScanCubit(),
              child: BlocBuilder<ProductScanCubit, ProductScanState>(
                builder: (context, state) {
                  return HomeToolsComponent(
                    icon: Icons.qr_code_rounded,
                    title: S.of(context).scanBarcode,
                    onTapped: () => context
                        .read<ProductScanCubit>()
                        .scanBarcodeByCamera(context),
                  );
                },
              ),
            ),
            SizedBox(width: 8.w),
            BlocProvider(
              create: (_) => ProductScanCubit(),
              child: BlocBuilder<ProductScanCubit, ProductScanState>(
                builder: (context, state) {
                  return HomeToolsComponent(
                    icon: Icons.image_search_rounded,
                    title: S.of(context).imageAnalysis,
                    onTapped: () => context
                        .read<ProductScanCubit>()
                        .imageAnalysisScan(context),
                  );
                },
              ),
            ),
            SizedBox(width: 8.w),
            HomeToolsComponent(
              icon: Icons.short_text_outlined,
              title: S.of(context).editText,
              onTapped: () {
                HapticFeedback.vibrate();
                EditTextSheetContent.showEditTextBottomSheet(context);
              },
            ),
            SizedBox(width: 8.w),
            HomeToolsComponent(
              icon: Icons.map_outlined,
              title: S.of(context).palatineMap,
              onTapped: () {
                HapticFeedback.vibrate();
                Navigator.pushNamed(context, Routes.palatineMap);
              },
            ),
            SizedBox(width: 8.w),
            HomeToolsComponent(
              icon: Icons.volunteer_activism_outlined,
              title: S.of(context).donate,
              onTapped: () {
                HapticFeedback.vibrate();
                DonationSheetContent.showDonationBottomSheet(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}