import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/config/const/sensei_const.dart';
import '../../../../../core/widgets/text_filed_component/text_filed_component.dart';
import '../../logic/bloc/logs_bloc.dart';
import '../../logic/bloc/logs_event.dart';
import 'logs_search_content.dart';

class LogsPageView extends StatefulWidget {
  const LogsPageView({super.key});

  @override
  State<LogsPageView> createState() => _LogsPageViewState();
}

class _LogsPageViewState extends State<LogsPageView> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'SerialNumber';

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.all(SenseiConst.padding),
      child: Column(
        children: [
          searchBar(context),
          SizedBox(height: SenseiConst.margin.h),
          LogsSearchContent(searchController: _searchController),
        ],
      ),
    );

  Row searchBar(final BuildContext context) => Row(
      children: [
        Expanded(
          child: TextFieldComponent(
            useOutBorderRadius: true,
            controller: _searchController,
            icon: Icons.search,
            suffixIcon: menuButton(context),
            hint:
                'ابحث عن ${_selectedFilter == 'Name'
                    ? 'اسم المنتج'
                    : _selectedFilter == 'SerialNumber'
                    ? 'الرقم التسلسلي'
                    : _selectedFilter == 'Manufacture'
                    ? 'المُصنع'
                    : 'القسم'}...',
            onChange: (final value) {
              BlocProvider.of<LogsBloc>(
                context,
              ).add(GetLogsResult(value, _selectedFilter));
            },
          ),
        ),
      ],
    );

  PopupMenuButton<String> menuButton(final BuildContext context) => PopupMenuButton<String>(
      onSelected: (final value) {
        setState(() {
          _selectedFilter = value;
        });
      },
      icon: Icon(
        Icons.filter_list,
        size: SenseiConst.iconSize,
        color: _selectedFilter != 'SerialNumber'
            ? Theme.of(context).colorScheme.primary
            : null,
      ),
      elevation: 0,
      enableFeedback: true,
      borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withAlpha(0x80),
        ),
      ),
      padding: EdgeInsets.zero,
      tooltip: 'فلتر البحث',
      color: Theme.of(context).colorScheme.surface,
      itemBuilder: (final context) => [
          PopupMenuItem(
            value: 'SerialNumber',
            child: Row(
              children: [
                const Icon(Icons.qr_code_rounded, size: SenseiConst.iconSize),
                SizedBox(width: SenseiConst.padding.w),
                Text(
                  'الرقم التسلسلي',
                  style: TextStyle(
                    color: _selectedFilter == 'SerialNumber'
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                ),
                if (_selectedFilter == 'SerialNumber') ...[
                  const Spacer(),
                  Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                    size: SenseiConst.iconSize * 0.8,
                  ),
                ],
              ],
            ),
          ),
          PopupMenuItem(
            value: 'Name',
            child: Row(
              children: [
                const Icon(
                  Icons.label_outline_rounded,
                  size: SenseiConst.iconSize,
                ),
                SizedBox(width: SenseiConst.padding.w),
                Text(
                  'اسم المنتج',
                  style: TextStyle(
                    color: _selectedFilter == 'Name'
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                  ),
                ),
                if (_selectedFilter == 'Name') ...[
                  const Spacer(),
                  Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                    size: SenseiConst.iconSize * 0.8,
                  ),
                ],
              ],
            ),
          ),
          PopupMenuItem(
            value: 'Manufacture',
            child: Row(
              children: [
                const Icon(Icons.business, size: SenseiConst.iconSize),
                SizedBox(width: SenseiConst.padding.w),
                Text(
                  'المُصنع',
                  style: TextStyle(
                    color: _selectedFilter == 'Manufacture'
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                ),
                if (_selectedFilter == 'Manufacture') ...[
                  const Spacer(),
                  Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                    size: SenseiConst.iconSize * 0.8,
                  ),
                ],
              ],
            ),
          ),
          PopupMenuItem(
            value: 'Category',
            child: Row(
              children: [
                const Icon(Icons.category_outlined, size: SenseiConst.iconSize),
                SizedBox(width: SenseiConst.padding.w),
                Text(
                  'القسم',
                  style: TextStyle(
                    color: _selectedFilter == 'Category'
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                ),
                if (_selectedFilter == 'Category') ...[
                  const Spacer(),
                  Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                    size: SenseiConst.iconSize * 0.8,
                  ),
                ],
              ],
            ),
          ),
        ],
    );

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
