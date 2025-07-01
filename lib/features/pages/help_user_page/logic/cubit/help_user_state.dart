import 'package:equatable/equatable.dart';
import '../../data/model/qna_model.dart';

abstract class HelpUserState extends Equatable {
  const HelpUserState();

  @override
  List<Object> get props => [];
}

class HelpUserInitial extends HelpUserState {}

class HlepUserLoadingQnaState extends HelpUserState {}

class HlepUserLoadingQnaStateSuccess extends HelpUserState {
  const HlepUserLoadingQnaStateSuccess(this.qnaList);
  final List<QnaModel> qnaList;

  @override
  List<Object> get props => [qnaList];
}

class HelpUserErrorState extends HelpUserState {
  const HelpUserErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
