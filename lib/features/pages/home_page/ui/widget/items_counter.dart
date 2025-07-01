import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/const/sensei_const.dart';
import '../../../../../core/widgets/counter_items_component/counter_items_component.dart';
import '../../../../../generated/l10n.dart';
import '../../../../counter_manager/logic/counter_cubit.dart';
import '../../../../products_scanner/data/repository/fire_store_repositories.dart';
import '../../../../products_scanner/data/repository/objectbox_repositories.dart';

class ItemsCounter extends StatelessWidget {
  const ItemsCounter({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
      create: (final context) => CounterCubit()..fetchCounts(),
      child: const ItemsCounterView(),
    );

  String formatNumber(final int number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }
}

class ItemsCounterView extends StatelessWidget {
  const ItemsCounterView({super.key});

  @override
  Widget build(final BuildContext context) {
    final formatter = context
        .findAncestorWidgetOfExactType<ItemsCounter>()
        ?.formatNumber;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStreamCounter(
          stream: ObjectboxRepository().getTadamonLogsProductsCount(),
          icon: Icons.qr_code_rounded,
          title: S.of(context).scanBarcode,
          formatter: formatter!,
        ),
        SizedBox(width: SenseiConst.margin.w),
        _buildStreamCounter(
          stream: FireStoreRepository().getProductsCount(),
          icon: Icons.checklist_rounded,
          title: S.of(context).supportedProducts,
          formatter: formatter,
        ),
      ],
    );
  }

  Widget _buildStreamCounter({
    required final Stream<int> stream,
    required final IconData icon,
    required final String title,
    required final String Function(int) formatter,
  }) => StreamBuilder<int>(
      stream: stream,
      builder: (final context, final snapshot) {
        if (snapshot.hasError) {
          return Expanded(
            child: CounterItemsComponent(
              icon: Icons.error_outline_rounded,
              title: title,
              targetValue: 0,
            ),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Expanded(
            child: CounterItemsComponent(
              icon: Icons.timer_outlined,
              title: title,
              targetValue: 0,
            ),
          );
        }

        final count = snapshot.data!;
        return Expanded(
          child: CounterItemsComponent(
            icon: icon,
            title: title,
            targetValue: count,
          ),
        );
      },
    );
}
