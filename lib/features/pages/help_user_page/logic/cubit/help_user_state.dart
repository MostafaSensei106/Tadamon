import 'package:equatable/equatable.dart';
import 'package:tadamon/features/pages/help_user_page/data/model/qna_model.dart';

abstract class HelpUserState extends Equatable {
  const HelpUserState();

  @override
  List<Object> get props => [];
}

class HelpUserInitial extends HelpUserState {}

class HlepUserLoadingQnaState extends HelpUserState {}

class HlepUserLoadingQnaStateSuccess extends HelpUserState {
  final List<QnaModel> qnaList;

  const HlepUserLoadingQnaStateSuccess(this.qnaList);

  @override
  List<Object> get props => [qnaList];
}

class HelpUserErrorState extends HelpUserState {
  final String error;

  const HelpUserErrorState(this.error);

  @override
  List<Object> get props => [error];
}
