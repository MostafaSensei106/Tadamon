import 'package:equatable/equatable.dart';
import '../../data/models/scanned_logs_product_model.dart';

abstract class LogsState extends Equatable {
  @override
  List<Object> get props => [];
}

class LogsInitial extends LogsState {}

class LogsLoading extends LogsState {}

class LogsLoadingSuccess extends LogsState {
  LogsLoadingSuccess({required this.products});
  final List<ScannedLogsProductModel> products;

  @override
  List<Object> get props => [products];
}

class LogsError extends LogsState {
  LogsError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
