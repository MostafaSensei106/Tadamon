import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/features/pages/log_page/logic/bloc/logs_bloc.dart';
import 'package:tadamon/features/pages/log_page/logic/bloc/logs_event.dart';
import 'package:tadamon/features/pages/log_page/ui/widgets/logs_page_view.dart';
import 'package:tadamon/features/products_scanner/data/repository/objectbox_repositories.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogsBloc(ObjectboxRepository())..add(GetAllLogs()),
      child: const LogsPageView(),
    );
  }
}
