import 'package:heart_rate/repository/models/heart_rate_model.dart';

abstract class AbstractHeartRateRepository {
  Future<List<HeartRateModel>> getAllHeartRete();
  Future<List<HeartRateModel>> getFirstThreeHeartRete();
  Future<void> addHeartRate(HeartRateModel heartRate);
  Future<void> editHeartRate(
      HeartRateModel oldheartRate, HeartRateModel newheartRate);
  Future<void> deleteHeartRate(HeartRateModel heartRate);
}
