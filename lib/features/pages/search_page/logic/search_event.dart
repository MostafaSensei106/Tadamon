import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchSearchResult extends SearchEvent {

  FetchSearchResult(this.query, this.filter);
  final String query, filter;

  @override
  List<Object> get props => [query, filter];
}
