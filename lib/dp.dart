// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:get_it/get_it.dart';
import 'package:talker/talker.dart';

final dp = GetIt.instance;

void init() {
  dp..registerLazySingleton(Talker.new);
}
