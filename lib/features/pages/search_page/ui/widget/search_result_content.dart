import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/config/const/sensei_const.dart';
import '../../../../../core/widgets/lottie_component/lottie_component.dart';
import '../../logic/search_bloc.dart';
import '../../logic/search_state.dart';
import 'product_expansion_tile.dart';

class SearchResultContent extends StatelessWidget {
  const SearchResultContent({
    required final TextEditingController searchController, super.key,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(final BuildContext context) => Expanded(
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (final context, final state) {
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
              itemBuilder: (final context, final index) {
                final product = state.products[index];
                return ProductExpansionTileComponent(product: product);
              },
              separatorBuilder: (final context, final index) =>
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
