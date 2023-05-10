import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedsScreen extends ConsumerWidget {
  const FeedsScreen({super.key});

  static const path = '/feeds';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Center(
        child: Text('feeds'),
      ),
    );
  }
}
