import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/lottie_component/lottie_component.dart';
import 'package:tadamon/features/pages/search_page/logic/search_bloc.dart';
import 'package:tadamon/features/pages/search_page/logic/search_state.dart';
import 'package:tadamon/features/pages/search_page/ui/widget/product_expansion_tile.dart';

class SearchResultContent extends StatelessWidget {
  const SearchResultContent({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchLoadingSuccess) {
            if (state.products.isEmpty) {
              return _searchController.text.isEmpty
                  ? const LottieComponent(
                      lottiePath: SenseiConst.lottieSearchAnimation,
                      text: 'نتائج البحث سوف تظهر هنا',
                    )
                  : const LottieComponent(
                      lottiePath: SenseiConst.lottieNoFoundAnimation,
                      text: 'لم يتم العثور على المنتج',
                    );
            }
            return ListView.separated(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ProductExpansionTileComponent(product: product);
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: SenseiConst.margin.h),
            );
          } else if (state is SearchError) {
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
}
