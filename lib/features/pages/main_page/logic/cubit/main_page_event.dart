import 'package:equatable/equatable.dart';

abstract class MainPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PageChanged extends MainPageEvent {

  PageChanged(this.index);
  final int index;

  @override
  List<Object> get props => [index];
}
