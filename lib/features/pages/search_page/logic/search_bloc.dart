import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../products_scanner/data/repository/fire_store_repositories.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.repository) : super(SearchInitial()) {
    on<FetchSearchResult>(_onFeatchSearchResult);
  }
  final FireStoreRepository repository;

  void _onFeatchSearchResult(
    final FetchSearchResult event,
    final Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());
    try {
      final products = await repository.searchInFireStore(
        event.query,
        event.filter,
      );
      emit(SearchLoadingSuccess(const [], products: products));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
