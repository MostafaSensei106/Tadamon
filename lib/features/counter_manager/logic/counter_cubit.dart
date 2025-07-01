import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/app_toast/app_toast.dart';
import '../../products_scanner/data/repository/fire_store_repositories.dart';
import '../../products_scanner/data/repository/objectbox_repositories.dart';
import 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(objectBoxCount: 0, firebaseCount: 0));

  StreamSubscription<int>? _objectBoxSubscription;
  StreamSubscription<int>? _fireStoreSubscription;

  Future<void> fetchCounts() async {
    try {
      _objectBoxSubscription = ObjectboxRepository()
          .getTadamonLogsProductsCount()
          .listen((final count) {
            emit(state.copyWith(objectBoxCount: count));
          });

      _fireStoreSubscription = FireStoreRepository().getProductsCount().listen((
        final count,
      ) {
        emit(state.copyWith(firebaseCount: count));
      });
    } catch (e, s) {
      AppToast.showErrorToast('Error fetching counts: $e\n$s');
    }
  }

  @override
  Future<void> close() {
    _objectBoxSubscription?.cancel();
    _fireStoreSubscription?.cancel();
    return super.close();
  }
}
