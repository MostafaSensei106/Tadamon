part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  const HomeLoaded({required this.imageUrls, required this.currentPage});
  final List<String> imageUrls;
  final int currentPage;

  @override
  List<Object> get props => [imageUrls, currentPage];
}

final class HomeError extends HomeState {
  const HomeError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
