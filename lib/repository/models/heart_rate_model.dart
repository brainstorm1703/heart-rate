import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'heart_rate_model.g.dart';

@HiveType(typeId: 1)
class HeartRateModel extends Equatable {
  @HiveField(1)
  final int systolic;
  @HiveField(2)
  final int diastolic;
  @HiveField(3)
  final int pulse;
  @HiveField(4)
  final String date;
  @HiveField(5)
  final String time;

  const HeartRateModel({
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    required this.date,
    required this.time,
  });
  @override
  List<Object> get props {
    return [
      systolic,
      diastolic,
      pulse,
      date,
      time,
    ];
  }
}
