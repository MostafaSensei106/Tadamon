import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_page_state.dart';

class PageCubit extends Cubit<MainPageState> {
  PageCubit() : super(const MainPageState());

  void changePage(final AppPage page) {
    emit(state.copyWith(currentPage: page));
  }
}
