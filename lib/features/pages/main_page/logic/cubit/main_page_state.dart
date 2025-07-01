enum AppPage { image, video, saved, home, search, logs }

class MainPageState {
  const MainPageState({this.currentPage = AppPage.image});
  final AppPage currentPage;

  MainPageState copyWith({final AppPage? currentPage}) =>
      MainPageState(currentPage: currentPage ?? this.currentPage);
}
