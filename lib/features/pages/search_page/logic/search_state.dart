import 'package:equatable/equatable.dart';
import 'package:tadamon/features/pages/search_page/data/model/search_product_model.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoadingSuccess extends SearchState {
  final List<ProductSearchModel> products;

  SearchLoadingSuccess(List result, {required this.products});

  @override
  List<Object> get props => [products];
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}
