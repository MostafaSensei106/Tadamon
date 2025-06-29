import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/features/pages/search_page/logic/search_event.dart';
import 'package:tadamon/features/pages/search_page/logic/search_state.dart';
import 'package:tadamon/features/products_scanner/data/repository/fire_store_repositories.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final FireStoreRepository repository;

  SearchBloc(this.repository) : super(SearchInitial()) {
    on<FetchSearchResult>(_onFeatchSearchResult);
  }

  void _onFeatchSearchResult(
    FetchSearchResult event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());
    try {
      final products = await repository.searchInFireStore(
        event.query,
        event.filter,
      );
      emit(SearchLoadingSuccess([], products: products));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
