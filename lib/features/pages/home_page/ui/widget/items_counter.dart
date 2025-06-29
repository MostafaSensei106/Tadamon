import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/counter_items_component/counter_items_component.dart';
import 'package:tadamon/features/counter_manager/logic/counter_cubit.dart';
import 'package:tadamon/features/products_scanner/data/repository/fire_store_repositories.dart';
import 'package:tadamon/features/products_scanner/data/repository/objectbox_repositories.dart';
import 'package:tadamon/generated/l10n.dart';

class ItemsCounter extends StatelessWidget {
  const ItemsCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit()..fetchCounts(),
      child: const ItemsCounterView(),
    );
  }

  String formatNumber(int number) {
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
  Widget build(BuildContext context) {
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
    required Stream<int> stream,
    required IconData icon,
    required String title,
    required String Function(int) formatter,
  }) {
    return StreamBuilder<int>(
      stream: stream,
      builder: (context, snapshot) {
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
}
