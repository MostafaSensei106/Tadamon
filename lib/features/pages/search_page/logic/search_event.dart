import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchSearchResult extends SearchEvent {
  final String query, filter;

  FetchSearchResult(this.query, this.filter);

  @override
  List<Object> get props => [query, filter];
}
