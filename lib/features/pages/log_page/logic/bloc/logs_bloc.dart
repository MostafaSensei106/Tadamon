import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../products_scanner/data/repository/objectbox_repositories.dart';
import 'logs_event.dart';
import 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  LogsBloc(this.repository) : super(LogsInitial()) {
    on<GetAllLogs>(_onGetAllLogs);
    on<GetLogsResult>(_onFeatchSearchResult);
  }
  final ObjectboxRepository repository;

  void _onGetAllLogs(
    final GetAllLogs event,
    final Emitter<LogsState> emit,
  ) async {
    emit(LogsLoading());
    try {
      final products = await repository.getAllTadamonLogs();
      emit(LogsLoadingSuccess(products: products));
    } catch (e) {
      emit(LogsError(e.toString()));
    }
  }

  void _onFeatchSearchResult(
    final GetLogsResult event,
    final Emitter<LogsState> emit,
  ) async {
    emit(LogsLoading());
    try {
      final products = await repository.searchProductsBySerialNumber(
        event.query,
      );
      emit(LogsLoadingSuccess(products: products));
    } catch (e) {
      emit(LogsError(e.toString()));
    }
  }
}
