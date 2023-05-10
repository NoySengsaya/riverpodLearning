import 'package:flutter_riverpod/flutter_riverpod.dart';

int currentPageIndex = 0;

class PageNotifier extends Notifier<int> {
  int get pageIndex => currentPageIndex;

  @override
  int build() {
    // init page index to 0
    return currentPageIndex;
  }

  void changePage(int index) {
    currentPageIndex = index;

    state = currentPageIndex;
  }
}

final pageNotifierProvider = NotifierProvider<PageNotifier, int>(
  () => PageNotifier(),
);
