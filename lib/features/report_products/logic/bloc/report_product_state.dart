abstract class ReportProductState {}

class ReportProductInitial extends ReportProductState {}

class ReportProductIsValid extends ReportProductState {}

class ReportProductSerialNumberIsNotValid extends ReportProductState {
  ReportProductSerialNumberIsNotValid(this.error);
  final String error;
}

class ReportProductProductNameIsNotValid extends ReportProductState {
  ReportProductProductNameIsNotValid(this.error);
  final String error;
}

class ReportProductIsLoading extends ReportProductState {}

class ReportProductIsNotValid extends ReportProductState {}

class ReportProductIsError extends ReportProductState {
  ReportProductIsError(this.error);
  final String error;
}
