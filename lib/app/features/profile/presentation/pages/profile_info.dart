import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:rpod/app/features/auth/presentation/widgets/information_tile.dart';

class ProfileInfoScreen extends ConsumerWidget {
  const ProfileInfoScreen({
    super.key,
    this.record,
  });

  static const path = 'info';

  final RecordModel? record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile Info'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              InformationTile(
                label: 'Name',
                title: record?.data['name'],
                titleStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.teal,
                ),
                verified: record?.data['verified'],
              ),
              const SizedBox(height: 10),
              InformationTile(
                label: 'E-mail',
                title: record?.data['email'],
                titleStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),
              InformationTile(
                label: 'Phone',
                title: record?.data['phone'],
                titleStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
