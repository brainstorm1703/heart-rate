import 'package:heart_rate/repository/abstract_heart_rate_repository.dart';
import 'package:heart_rate/repository/models/heart_rate_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HeartRateRepository extends AbstractHeartRateRepository {
  final Box<HeartRateModel> heartRateBox;

  HeartRateRepository({required this.heartRateBox});

  @override
  Future<List<HeartRateModel>> getAllHeartRete() async {
    final heartRateList = heartRateBox.values.toList();
    heartRateList.sort((a, b) {
      int dateComparison = a.date.compareTo(b.date);
      if (dateComparison != 0) {
        return dateComparison;
      } else {
        return b.time.compareTo(a.time);
      }
    });
    return Future.value(heartRateList);
  }

  @override
  Future<List<HeartRateModel>> getFirstThreeHeartRete() async {
    final heartRateList = heartRateBox.values.toList();
    heartRateList.sort((a, b) {
      int dateComparison = a.date.compareTo(b.date);
      if (dateComparison != 0) {
        return dateComparison;
      } else {
        return b.time.compareTo(a.time);
      }
    });
    if (heartRateList.length < 3) return Future.value(heartRateList);
    return Future.value(heartRateList.sublist(0, 3));
  }

  @override
  Future<void> addHeartRate(HeartRateModel heartRate) async {
    await heartRateBox.put(_createKey(heartRate), heartRate);
  }

  @override
  Future<void> editHeartRate(
      HeartRateModel oldheartRate, HeartRateModel newheartRate) async {
    deleteHeartRate(oldheartRate);
    addHeartRate(newheartRate);
  }

  @override
  Future<void> deleteHeartRate(HeartRateModel heartRate) async {
    await heartRateBox.delete(_createKey(heartRate));
  }

  String _createKey(HeartRateModel heartRate) {
    return heartRate.systolic.toString() +
        heartRate.diastolic.toString() +
        heartRate.pulse.toString() +
        heartRate.date +
        heartRate.time;
  }
}
