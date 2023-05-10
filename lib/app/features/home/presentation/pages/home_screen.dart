import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpod/app/core/api/pocketbase_provider.dart';

import '../../../auth/presentation/riverpod/login_provider.dart';
import '../../../feeds/feeds.dart';
import '../../../profile/profile.dart';
import '../riverpod/home_provider.dart';
import '../riverpod/page_provder.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  // path
  static const path = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);
    final pageState = ref.watch(pageNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: buildAppBarTitle(
          context,
          ref.read(pageNotifierProvider.notifier).pageIndex,
        ),
        actions: [
          IconButton(
            onPressed: ref.read(pocketbaseProvider.notifier).logout,
            icon: const Icon(
              Icons.logout_outlined,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: ref.read(pageNotifierProvider.notifier).pageIndex,
          children: const [
            FeedsScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ref.read(pageNotifierProvider.notifier).pageIndex,
        onTap: ref.read(pageNotifierProvider.notifier).changePage,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
              color: Colors.grey,
            ),
            activeIcon: Icon(Icons.rss_feed_outlined),
            label: 'Feeds',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color: Colors.grey,
            ),
            activeIcon: const Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  buildAppBarTitle(
    BuildContext context,
    int index,
  ) {
    switch (index) {
      case 0:
        return Text('Feeds');
      case 1:
        return Text('Profile');
      default:
        return Text('Riverpod');
    }
  }
}
