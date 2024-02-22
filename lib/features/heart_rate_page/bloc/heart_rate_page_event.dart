part of 'heart_rate_page_bloc.dart';

abstract class HeartRatePageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddHeartRate extends HeartRatePageEvent {
  final HeartRateModel heartRate;

  AddHeartRate({required this.heartRate});
  @override
  List<Object> get props => [heartRate];
}

class EditHeartRate extends HeartRatePageEvent {
  final HeartRateModel oldHeartRate;
  final HeartRateModel newHeartRate;

  EditHeartRate({required this.oldHeartRate, required this.newHeartRate});
  @override
  List<Object> get props => [oldHeartRate, newHeartRate];
}

class DeleteHeartRate extends HeartRatePageEvent {
  final HeartRateModel heartRate;

  DeleteHeartRate({required this.heartRate});
  @override
  List<Object> get props => [heartRate];
}
