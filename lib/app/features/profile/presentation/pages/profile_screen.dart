import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rpod/app/features/profile/presentation/riverpod/profile_provider.dart';
import 'package:rpod/app/features/profile/presentation/widgets/profile_card_sector.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static const path = '/profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(profileProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            children: [
              // profile sector
              FutureBuilder(
                initialData: null,
                future: ref.read(profileProvider.notifier).fetchUserInfo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final userData = snapshot.data!;
                    return InkWell(
                      onTap: () => context.push(
                        '/profile/info',
                        extra: userData,
                      ),
                      // onTap: () {},
                      child: ProfileCardSector(
                        userName: userData.data['username'],
                        name: userData.data['name'],
                        onEdit: () => context.push('/profile/edit'),
                        // onEdit: () => context.pushNamed('profile-edit'),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CupertinoActivityIndicator(
                        radius: 15,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
