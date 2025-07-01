import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/objectbox_repositories.dart';

part 'localdb_state.dart';

class LocalDBCubit extends Cubit<LocalDBState> {
  LocalDBCubit() : super(LoclaDBDataIntial());

  Future<void> fetchDataFromFireStore() async {
    emit(LoclaDBDataFetchingFromFireStore());
    try {
      await ObjectboxRepository().syncAllProductsToLocalDB();
      emit(LoclaDBDataFetchingFromFireStoreSuccess());
    } catch (e) {
      emit(LoclaDBDataFetchingFromFireStoreFailure());
    }
  }

  Future<void> updateDataBaseFromFireStore() async {
    emit(LoclaDBDataFetchingFromFireStore());
    try {
      await ObjectboxRepository().syncAllProductsToLocalDB();
      emit(LoclaDBDataFetchingFromFireStoreSuccess());
    } catch (e) {
      emit(LoclaDBDataFetchingFromFireStoreFailure());
    }
  }

  Future<void> deleteAllLocalProducts() async {
    emit(LoclaDBDataBaseDeleting());
    try {
      await ObjectboxRepository().deleteAllTadamonProductsFromLocalDB();
      emit(LoclaDBDataDeleteSuccess());
    } catch (e) {
      emit(LoclaDBDataDeleteFailure());
    }
  }

  Future<bool> loclaDBHasData() async {
    final hasData = await ObjectboxRepository().tadamonProductsBoxHasData();
    if (hasData) {
      emit(LoclaDBDataBaseHasData());
      return true;
    } else {
      emit(LoclaDBDataBaseEmpty());
      return false;
    }
  }
}
