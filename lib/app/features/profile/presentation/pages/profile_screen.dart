import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpod/app/core/api/pocketbase_provider.dart';
import 'package:rpod/app/features/profile/presentation/riverpod/profile_provider.dart';
import 'package:rpod/app/features/profile/presentation/widgets/profile_card_sector.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static const path = '/profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(profileProvider);
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
                    return ProfileCardSector(
                      userName: userData.data['username'],
                      name: userData.data['name'],
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
