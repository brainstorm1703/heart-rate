import 'package:flutter/material.dart';
import 'package:heart_rate/repository/abstract_heart_rate_repository.dart';
import 'package:heart_rate/repository/heart_rate_repository.dart';
import 'package:heart_rate/repository/models/heart_rate_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:heart_rate/heart_rate_app.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  const heartRateBoxName = 'heart_rate_box';
  await Hive.initFlutter();
  Hive.registerAdapter(HeartRateModelAdapter());

  final heartRateBox = await Hive.openBox<HeartRateModel>(heartRateBoxName);

  GetIt.I.registerLazySingleton<AbstractHeartRateRepository>(
      () => HeartRateRepository(heartRateBox: heartRateBox));
  runApp(const HeartRateApp());
}
