import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../products_scanner/data/repository/objectbox_repositories.dart';
import '../../logic/bloc/logs_bloc.dart';
import '../../logic/bloc/logs_event.dart';
import '../widgets/logs_page_view.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
      create: (final context) => LogsBloc(ObjectboxRepository())..add(GetAllLogs()),
      child: const LogsPageView(),
    );
}
