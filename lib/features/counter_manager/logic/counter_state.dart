class CounterState {

  CounterState({required this.objectBoxCount, required this.firebaseCount});
  final int objectBoxCount;
  final int firebaseCount;

  CounterState copyWith({final int? objectBoxCount, final int? firebaseCount}) => CounterState(
      objectBoxCount: objectBoxCount ?? this.objectBoxCount,
      firebaseCount: firebaseCount ?? this.firebaseCount,
    );
}
