import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/config/const/sensei_const.dart';
import '../../../../../core/widgets/lottie_component/lottie_component.dart';
import '../../logic/bloc/logs_bloc.dart';
import '../../logic/bloc/logs_state.dart';
import 'productlogs_expansiontile_component.dart';

class LogsSearchContent extends StatelessWidget {

  const LogsSearchContent({required this.searchController, super.key});
  final TextEditingController searchController;

  @override
  Widget build(final BuildContext context) => Expanded(
      child: BlocBuilder<LogsBloc, LogsState>(
        builder: (final context, final state) {
          // أضف منطق البحث هنا
          if (searchController.text.isNotEmpty && state is LogsLoadingSuccess) {
            final filteredProducts = state.products.where((final product) => product.serialNumber.contains(searchController.text)).toList();

            if (filteredProducts.isEmpty) {
              return const LottieComponent(
                lottiePath: SenseiConst.lottieNoFoundAnimation,
                text: 'هذا المنتج غير موجود في السجلات',
              );
            }

            return ListView.separated(
              itemCount: filteredProducts.length,
              itemBuilder: (final context, final index) {
                final product = filteredProducts[index];
                return ProductLogsExpansionTileComponent(product: product);
              },
              separatorBuilder: (final context, final index) =>
                  SizedBox(height: SenseiConst.margin.h),
            );
          }

          // الحالة العادية عند عدم البحث
          if (state is LogsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LogsLoadingSuccess) {
            if (state.products.isEmpty) {
              return const LottieComponent(
                lottiePath: SenseiConst.lottieSearchAnimation,
                text: 'نتائج البحث سوف تظهر هنا',
              );
            }
            return ListView.separated(
              itemCount: state.products.length,
              itemBuilder: (final context, final index) {
                final product = state.products[index];
                return ProductLogsExpansionTileComponent(product: product);
              },
              separatorBuilder: (final context, final index) =>
                  SizedBox(height: SenseiConst.margin.h),
            );
          } else if (state is LogsError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(
              child: LottieComponent(
                lottiePath: SenseiConst.lottieSearchAnimation,
                text: 'نتائج البحث سوف تظهر هنا',
              ),
            );
          }
        },
      ),
    );
}
