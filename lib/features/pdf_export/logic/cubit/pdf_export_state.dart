import 'package:equatable/equatable.dart';

abstract class PdfExportState extends Equatable {
  const PdfExportState();

  @override
  List<Object> get props => [];
}

class PdfExportInitial extends PdfExportState {
  const PdfExportInitial({this.logCount = 0, this.dateRange = ''});

  final int logCount;
  final String dateRange;

  @override
  List<Object> get props => [logCount, dateRange];
}

class PdfExportLoading extends PdfExportState {}

class PdfExportSuccess extends PdfExportState {}

class PdfExportError extends PdfExportState {}
