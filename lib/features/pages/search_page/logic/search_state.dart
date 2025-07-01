import 'package:equatable/equatable.dart';
import '../data/model/search_product_model.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoadingSuccess extends SearchState {

  SearchLoadingSuccess(List list, {required this.products});
  final List<ProductSearchModel> products;

  @override
  List<Object> get props => [products];
}

class SearchError extends SearchState {

  SearchError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
