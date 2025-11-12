import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static const Duration _autoSlideDuration = Duration(seconds: 3);
  Timer? _autoSlideTimer;

  final List<String> _imageUrls = [
    'https://cdnuploads.aa.com.tr/uploads/Contents/2023/10/21/thumbs_b_c_f90d9d191fa2cd8c00d134bc30ba251f.jpg?v=110742',
    'https://i.guim.co.uk/img/media/5d9ea77d27c95d327caee787ddc6af484faaa567/0_0_8192_4918/master/8192.jpg?width=1200&quality=85&auto=format&fit=max&s=bf17013c1bd811669951ebcda28e7c95',
    'https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iSuF7fmisxDk/v0/-1x-1.webp',
    'https://bloximages.chicago2.vip.townnews.com/thestar.com/content/tncms/assets/v3/editorial/a/68/a68570e5-2f7a-5994-aaa5-52278b1af463/664db1ba2f511.image.jpg?crop=1280%2C672%2C0%2C90&resize=1200%2C630&order=crop%2Cresize',
  ];

  void loadContent() {
    emit(HomeLoaded(imageUrls: _imageUrls, currentPage: 0));
    _startAutoSlide();
  }

  void pageChanged(final int page) {
    if (state is HomeLoaded) {
      emit(HomeLoaded(imageUrls: _imageUrls, currentPage: page));
    }
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(_autoSlideDuration, (_) {
      if (state is HomeLoaded) {
        final loadedState = state as HomeLoaded;
        final nextPage = (loadedState.currentPage + 1) % _imageUrls.length;
        pageChanged(nextPage);
      }
    });
  }

  void pauseAutoSlide() {
    _autoSlideTimer?.cancel();
  }

  void resumeAutoSlide() {
    _startAutoSlide();
  }

  @override
  Future<void> close() {
    _autoSlideTimer?.cancel();
    return super.close();
  }
}
