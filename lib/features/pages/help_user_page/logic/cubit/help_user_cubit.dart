import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/features/pages/help_user_page/data/repositories/repositories.dart';
import 'package:tadamon/features/pages/help_user_page/logic/cubit/help_user_state.dart';

class HelpUserCubit extends Cubit<HelpUserState> {
  HelpUserCubit() : super(HelpUserInitial()) {
    loadQna();
  }

  Future<void> loadQna() async {
    try {
      emit(HlepUserLoadingQnaState());
      final qnaList = await QnaRepositore.getQna();
      emit(HlepUserLoadingQnaStateSuccess(qnaList));
    } catch (e) {
      emit(HelpUserErrorState(e.toString()));
    }
  }

  void searchQA(String query) async {
    try {
      if (query.isEmpty) {
        final qnaList = await QnaRepositore.getQna();
        emit(HlepUserLoadingQnaStateSuccess(qnaList));
        return;
      }

      final allQna = await QnaRepositore.getQna();
      final filteredList = allQna
          .where(
            (qna) =>
                qna.question.toLowerCase().contains(query.toLowerCase()) ||
                qna.simAnswer.toLowerCase().contains(query.toLowerCase()) ||
                qna.fullAnswer.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();

      emit(HlepUserLoadingQnaStateSuccess(filteredList));
    } catch (e) {
      emit(HelpUserErrorState(e.toString()));
    }
  }
}
